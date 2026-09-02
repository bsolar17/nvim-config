return {
    "dlyongemallo/diffview-plus.nvim",
    version = "*",
    opts = function()
        local actions = require("diffview.actions")
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
                file_history_panel = {
                    {
                        "n",
                        "P",
                        actions.open_in_diffview,
                        { desc = "Diff commit against its parent" },
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
