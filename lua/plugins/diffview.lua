---Path args of the log view a diffview replaced, so it can go back to it.
---@type table<table, string[]>
local origin_log = setmetatable({}, { __mode = "k" })

local function notify_commit(view)
    if not (view.right and view.right.commit) then
        return
    end

    local res = vim.system({
        "git",
        "-C",
        view.adapter.ctx.toplevel,
        "log",
        "-1",
        "--format=%h %s%n%an, %ar",
        view.right.commit,
    }, { text = true }):wait()

    if res.code == 0 then
        vim.notify(vim.trim(res.stdout), vim.log.levels.INFO)
    end
end

local function open_in_diffview_replacing()
    local lib = require("diffview.lib")
    local log = lib.get_current_view()

    require("diffview.actions").open_in_diffview()

    local view = lib.get_current_view()
    if not log or view == log then
        return
    end

    origin_log[view] = vim.deepcopy(log.adapter.ctx.path_args or {})
    log:close()
    lib.dispose_view(log)
    notify_commit(view)
end

---Go back to the log view, replacing the diffview.
local function back_to_log()
    local lib = require("diffview.lib")
    local view = lib.get_current_view()

    if not view then
        return
    end

    local cmd = {
        "DiffviewFileHistory",
        "-C" .. vim.fn.fnameescape(view.adapter.ctx.toplevel),
    }
    for _, path in ipairs(origin_log[view] or view.path_args or {}) do
        table.insert(cmd, vim.fn.fnameescape(path))
    end

    vim.cmd.DiffviewClose()
    vim.cmd(table.concat(cmd, " "))
end

---Default conflict keymaps under `<Leader>c`, which clash with the Code group.
---Spelled exactly as in the defaults: overrides are matched by literal lhs.
local default_conflict_lhs = {
    "<leader>co",
    "<leader>ct",
    "<leader>cb",
    "<leader>ca",
    "<leader>cO",
    "<leader>cT",
    "<leader>cB",
    "<leader>cA",
    "<leader>cso",
    "<leader>cst",
    "<leader>csb",
}

---Conflict keymaps moved under `<Leader>dc`.
---@param whole_file_only boolean Only the whole-file variants (file panel).
local function conflict_keymaps(whole_file_only)
    local actions = require("diffview.actions")
    local keymaps = {}
    for _, lhs in ipairs(default_conflict_lhs) do
        table.insert(keymaps, { "n", lhs, false })
    end
    local versions = {
        { "o", "ours", "OURS" },
        { "t", "theirs", "THEIRS" },
        { "b", "base", "BASE" },
        { "a", "all", "all the versions" },
    }
    for _, v in ipairs(versions) do
        local key, version, label = v[1], v[2], v[3]
        if not whole_file_only then
            table.insert(keymaps, {
                "n",
                "<Leader>dc" .. key,
                actions.conflict_choose(version),
                { desc = "Choose " .. label .. " (conflict)" },
            })
        end
        table.insert(keymaps, {
            "n",
            "<Leader>dc" .. key:upper(),
            actions.conflict_choose_all(version),
            { desc = "Choose " .. label .. " (whole file)" },
        })
        if not whole_file_only and version ~= "all" then
            table.insert(keymaps, {
                "n",
                "<Leader>dcs" .. key,
                actions.conflict_choose_side(version),
                { desc = "Replace with entire " .. label .. " side" },
            })
        end
    end
    return keymaps
end

return {
    "dlyongemallo/diffview-plus.nvim",
    version = "*",
    opts = function()
        return {
            view = {
                default = {
                    layout = "diff1_inline",
                },
                merge_tool = {
                    layout = "diff4_mixed",
                },
                cycle_layouts = {
                    default = { "diff1_inline", "diff2_horizontal" },
                },
            },
            keymaps = {
                diff1 = conflict_keymaps(false),
                diff3 = conflict_keymaps(false),
                diff4 = conflict_keymaps(false),
                file_panel = vim.list_extend({
                    {
                        "n",
                        "P",
                        back_to_log,
                        { desc = "Go back to the log view" },
                    },
                }, conflict_keymaps(true)),
                file_history_panel = {
                    {
                        "n",
                        "P",
                        open_in_diffview_replacing,
                        {
                            desc = "Diff the commit under the cursor",
                        },
                    },
                },
            },
        }
    end,
    config = function(_, opts)
        require("diffview").setup(opts)
        vim.keymap.set("n", "<Leader>dv", function()
            local lib = require("diffview.lib")
            local view = lib.get_current_view()
            if view then
                vim.cmd.DiffviewClose()
            else
                vim.cmd.DiffviewOpen()
            end
        end, { desc = "View" })
        vim.keymap.set(
            "n",
            "<Leader>df",
            "<Cmd>DiffviewFileHistory %<CR>",
            { desc = "File History" }
        )
        vim.keymap.set(
            "n",
            "<Leader>do",
            "<Cmd>DiffviewOpen origin/HEAD<CR>",
            { desc = "origin/HEAD" }
        )
        vim.keymap.set(
            "n",
            "<Leader>d1",
            "<Cmd>DiffviewOpen HEAD^1<CR>",
            { desc = "HEAD^1" }
        )
        vim.keymap.set(
            "n",
            "<Leader>dl",
            "<Cmd>DiffviewFileHistory<CR>",
            { desc = "Log" }
        )
    end,
}
