return {
    "folke/trouble.nvim",
    cond = not vim.g.vscode,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        height = 15,
    },
    config = function(_, opts)
        require("trouble").setup(opts)
        vim.keymap.set("n", "<leader>tt", function() require("trouble").toggle() end, { desc = "Toggle" })
        vim.keymap.set("n", "<leader>tw",
            function() require("trouble").toggle("workspace_diagnostics") end, { desc = "Workspace Diagnostics" })
        vim.keymap.set("n", "<leader>td",
            function() require("trouble").toggle("document_diagnostics") end, { desc = "Document Diagnostics" })
        vim.keymap.set("n", "<leader>tq", function() require("trouble").toggle("quickfix") end, { desc = "Quickfix" })
        vim.keymap.set("n", "<leader>tl", function() require("trouble").toggle("loclist") end, { desc = "Loclist" })
        vim.keymap.set("n", "tr", function() require("trouble").toggle("lsp_references") end, { desc = "References" })
    end
}
