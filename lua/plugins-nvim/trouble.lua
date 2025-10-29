return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        height = 15,
    },
    config = function(_, opts)
        require("trouble").setup(opts)
        vim.keymap.set(
            "n",
            "<Leader>tt",
            function() require("trouble").toggle() end,
            { desc = "Toggle" }
        )
        vim.keymap.set(
            "n",
            "<Leader>tw",
            function() require("trouble").toggle("diagnostics") end,
            { desc = "Workspace Diagnostics" }
        )
        vim.keymap.set(
            "n",
            "<Leader>tq",
            function() require("trouble").toggle("quickfix") end,
            { desc = "Quickfix" }
        )
        vim.keymap.set(
            "n",
            "<Leader>tl",
            function() require("trouble").toggle("loclist") end,
            { desc = "Loclist" }
        )
        vim.keymap.set(
            "n",
            "<Leader>tr",
            function() require("trouble").toggle("lsp_references") end,
            { desc = "References" }
        )
    end
}
