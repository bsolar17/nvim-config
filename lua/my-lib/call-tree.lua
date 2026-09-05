-- Drives litee-calltree.nvim's call hierarchy trees.
--
-- A call hierarchy request only ever returns one level; every further level is
-- another request, fired when a node is expanded. The `levels` entry points
-- chain those, blocking while the responses come back.
local EXPAND_LEVELS = 3
local EXPAND_BUDGET = 50
local REQUEST_TIMEOUT = 5000
local EXPAND_TIMEOUT = 2000
local TREE_TIMEOUT = 300

local PREPARE = "textDocument/prepareCallHierarchy"
local PREPARE_GRACE = 300
local INCOMING = "callHierarchy/incomingCalls"
local OUTGOING = "callHierarchy/outgoingCalls"

local M = {}

local function calltree_win()
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == "calltree" then
            return win, buf
        end
    end
end

local function tree_text(buf)
    return table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), "\n")
end

-- Waits on the request rather than on the tree buffer, which cannot tell this
-- request's tree from one an earlier request left behind; acting on a stale
-- tree makes litee restore a cursor line that no longer exists.
local function request(method, fire, timeout)
    local answered, sent, prepared = false, false, nil
    local autocmd = vim.api.nvim_create_autocmd("LspRequest", {
        callback = function(event)
            local pending = event.data.request
            if pending.method == method then
                answered = answered or pending.type == "complete"
                sent = sent or pending.type == "pending"
            elseif pending.method == PREPARE and pending.type == "complete" then
                prepared = vim.uv.hrtime() / 1e6
            end
        end,
    })
    local _, buf = calltree_win()
    local before = buf and tree_text(buf)
    fire()
    local _, reason = vim.wait(timeout, function()
        -- The call hierarchy request is sent from the response to the prepare
        -- request, so a prepare that resolved no symbol is a fast no.
        return answered
            or (
                prepared ~= nil
                and not sent
                and vim.uv.hrtime() / 1e6 - prepared > PREPARE_GRACE
            )
    end, 25)
    vim.api.nvim_del_autocmd(autocmd)
    if answered then
        vim.wait(TREE_TIMEOUT, function()
            local _, tree = calltree_win()
            return tree ~= nil and tree_text(tree) ~= before
        end, 10)
    end
    -- A prepare that resolved nothing is Neovim's "No item resolved", already
    -- reported by it; only a server that never answered is ours to report.
    return answered, reason, prepared ~= nil and not sent
end

local function expand_levels(method, levels)
    local calltree = require("litee.calltree")
    local collapsed = require("litee.lib").icon_set["Collapsed"]
    local budget = EXPAND_BUDGET
    -- The request that opened the tree already resolved the first level.
    for _ = 2, levels do
        local win, buf = calltree_win()
        if not win then
            return
        end
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        local targets = {}
        -- Bottom up, so expanding a node cannot shift the lines still queued.
        -- Line 1 is the root, whose children the request already resolved;
        -- re-expanding it would discard the levels resolved under it.
        for lnum = #lines, 2, -1 do
            if lines[lnum]:find(collapsed, 1, true) then
                table.insert(targets, lnum)
            end
        end
        if #targets == 0 then
            return
        end
        for _, lnum in ipairs(targets) do
            if budget == 0 then
                vim.notify(
                    "Call tree: stopped expanding after "
                        .. EXPAND_BUDGET
                        .. " nodes",
                    vim.log.levels.WARN
                )
                return
            end
            budget = budget - 1
            vim.api.nvim_win_set_cursor(win, { lnum, 0 })
            local _, reason = request(method, function()
                pcall(calltree.expand_calltree)
            end, EXPAND_TIMEOUT)
            if reason == -2 then -- interrupted with <C-c>
                return
            end
        end
    end
end

local function call_tree(fire, method, levels)
    return function()
        if #vim.lsp.get_clients({ bufnr = 0, method = PREPARE }) == 0 then
            fire() -- lets Neovim report that no attached server supports it
            return
        end
        -- Loads and configures the plugin, lazily. Lazy's own `keys` handler
        -- cannot: it loads from an expr mapping, where litee building its
        -- help buffer fails with E565.
        require("litee.calltree")
        local answered, _, unresolved = request(method, fire, REQUEST_TIMEOUT)
        if not answered then
            if not unresolved then
                vim.notify(
                    "No call tree: the language server did not answer "
                        .. "(is it done indexing?)",
                    vim.log.levels.WARN
                )
            end
            return
        end
        if levels then
            expand_levels(method, levels)
        end
        local win = calltree_win()
        if win then
            vim.api.nvim_win_set_cursor(win, { 1, 0 })
        end
    end
end

M.levels = EXPAND_LEVELS

M.incoming = call_tree(vim.lsp.buf.incoming_calls, INCOMING)
M.outgoing = call_tree(vim.lsp.buf.outgoing_calls, OUTGOING)
M.incoming_levels =
    call_tree(vim.lsp.buf.incoming_calls, INCOMING, EXPAND_LEVELS)
M.outgoing_levels =
    call_tree(vim.lsp.buf.outgoing_calls, OUTGOING, EXPAND_LEVELS)

function M.toggle_panel()
    require("litee.calltree")
    vim.cmd("LTPanel")
end

return M
