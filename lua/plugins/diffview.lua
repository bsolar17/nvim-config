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

return {
    "dlyongemallo/diffview-plus.nvim",
    version = "*",
    opts = function()
        return {
            view = {
                default = {
                    layout = "diff1_inline",
                },
                cycle_layouts = {
                    default = { "diff1_inline", "diff2_horizontal" },
                },
            },
            keymaps = {
                file_panel = {
                    {
                        "n",
                        "P",
                        back_to_log,
                        { desc = "Go back to the log view" },
                    },
                },
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
