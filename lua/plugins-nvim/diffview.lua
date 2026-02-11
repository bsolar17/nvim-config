return {
    "sindrets/diffview.nvim",
    opts = {},
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
