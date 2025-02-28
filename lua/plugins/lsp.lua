return {
    {
        "williamboman/mason.nvim",
        opts = {},
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        opts = {
            automatic_installation = true,
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
            }
        }
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("java").setup(
                {
                    jdk = {
                        auto_install = false,
                    }
                }
            )
            vim.keymap.set("n", "<Leader>ch", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Hover" })
            vim.keymap.set("n", "<Leader>gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>",
                { desc = "Definitions" })
            vim.keymap.set("n", "<Leader>gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { desc = "Declaration" })
            vim.keymap.set("n", "<Leader>gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>",
                { desc = "Implementations" })
            vim.keymap.set("n", "<Leader>gt", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<cr>",
                { desc = "Type Definitions" })
            vim.keymap.set("n", "<Leader>gr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>",
                { desc = "References" })
            vim.keymap.set("n", "<Leader>gI", "<cmd>lua require('telescope.builtin').lsp_incoming_calls()<cr>",
                { desc = "Incoming Calls" })
            vim.keymap.set("n", "<Leader>gO", "<cmd>lua require('telescope.builtin').lsp_outgoing_calls()<cr>",
                { desc = "Outgoing Calls" })
            vim.keymap.set("n", "<Leader>cs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { desc = "Signature Help" })
            vim.keymap.set("n", "<Leader>gs", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>",
                { desc = "Symbols" })
            vim.keymap.set("n", "<Leader>gm",
                "<cmd>lua require('telescope.builtin').lsp_document_symbols( {symbols = { 'method', 'function' } } )<cr>",
                { desc = "Methods" })
            vim.keymap.set("n", "<Leader>cd", "<cmd>lua require('telescope.builtin').diagnostics()<cr>",
                { desc = "Diagnostics" })
            vim.keymap.set("n", "<Leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename" })
            vim.keymap.set({ "n", "x" }, "<Leader>cf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
                { desc = "Format" })
            vim.keymap.set("n", "<Leader>cw", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Diagnostics Float" })
        end,
    },
}
