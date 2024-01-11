return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        -- LSP Support
        { "neovim/nvim-lspconfig" },
        -- Autocompletion
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "L3MON4D3/LuaSnip" },
        { "nvim-telescope/telescope.nvim" },
    },
    config = function()
        local lsp_zero = require("lsp-zero")
        lsp_zero.on_attach(function()
            vim.keymap.set("n", "<Leader>ch", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Hover" })
            vim.keymap.set("n", "<Leader>cd", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>",
                { desc = "Definitions" })
            vim.keymap.set("n", "<Leader>c=", "<cmd>lua vim.lsp.buf.declaration()<cr>", { desc = "Declaration" })
            vim.keymap.set("n", "<Leader>ci", "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>",
                { desc = "Implementations" })
            vim.keymap.set("n", "<Leader>ct", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<cr>",
                { desc = "Type Definitions" })
            vim.keymap.set("n", "<Leader>cr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>",
                { desc = "References" })
            vim.keymap.set("n", "<Leader>cI", "<cmd>lua require('telescope.builtin').lsp_incoming_calls()<cr>",
                { desc = "Incoming Calls" })
            vim.keymap.set("n", "<Leader>cO", "<cmd>lua require('telescope.builtin').lsp_outgoing_calls()<cr>",
                { desc = "Outgoing Calls" })
            vim.keymap.set("n", "<Leader>cS", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { desc = "Signature Help" })
            vim.keymap.set("n", "<Leader>cs", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>",
                { desc = "Symbols" })
            vim.keymap.set("n", "<Leader>cm", "<cmd>lua require('telescope.builtin').lsp_document_symbols( {symbols = { 'method', 'function' } } )<cr>",
                { desc = "Methods" })
            vim.keymap.set("n", "<Leader>cn", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename" })
            vim.keymap.set({ "n", "x" }, "<Leader>cf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
                { desc = "Format" })
            vim.keymap.set("n", "<Leader>cw", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Diagnostics Float" })
        end)
        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {},
            handlers = {
                lsp_zero.default_setup,
            },
        })
    end
}
