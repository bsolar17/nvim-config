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
            "<cmd>DiffviewFileHistory<cr>",
            { desc = "File History" }
        )
        vim.keymap.set(
            "n",
            "<Leader>do",
            "<cmd>DiffviewOpen origin/HEAD<cr>",
            { desc = "origin/HEAD" }
        )
        vim.keymap.set(
            "n",
            "<Leader>d1",
            "<cmd>DiffviewOpen HEAD^1<cr>",
            { desc = "HEAD^1" }
        )
    end,
}
