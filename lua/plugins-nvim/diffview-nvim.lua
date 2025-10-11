return {
    "sindrets/diffview.nvim",
    opts = {},
    config = function(_, opts)
        require("diffview").setup(opts)
        vim.keymap.set(
            "n",
            "<Leader>dv",
            function()
                local lib = require("diffview.lib")
                local view = lib.get_current_view()
                if view then
                    vim.cmd.DiffviewClose()
                else
                    vim.cmd.DiffviewOpen()
                end
            end,
            { desc = "View" }
        )
        vim.keymap.set(
            "n",
            "<Leader>dh",
            function()
                vim.cmd.DiffviewFileHistory()
            end,
            { desc = "History" }
        )
    end
}
