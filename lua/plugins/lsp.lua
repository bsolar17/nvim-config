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
        dependencies = {
            "nvim-java/nvim-java",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            local telescope_builtin = require("telescope.builtin")
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP attach',
                callback = function(event)
                    vim.opt.signcolumn = "yes"
                end,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
                desc = 'LSP detach',
                callback = function(event)
                    vim.opt.signcolumn = "no"
                end,
            })
            vim.diagnostic.config {
                float = { border = "rounded" },
            }
            vim.keymap.set("n", "<Leader>ch", vim.lsp.buf.hover, { desc = "Hover" })
            vim.keymap.set("n", "<Leader>gd", telescope_builtin.lsp_definitions,
                { desc = "Definitions" })
            vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration, { desc = "Declaration" })
            vim.keymap.set("n", "<Leader>gi", telescope_builtin.lsp_implementations,
                { desc = "Implementations" })
            vim.keymap.set("n", "<Leader>gt", telescope_builtin.lsp_type_definitions,
                { desc = "Type Definitions" })
            vim.keymap.set("n", "<Leader>gr", telescope_builtin.lsp_references,
                { desc = "References" })
            vim.keymap.set("n", "<Leader>gI", telescope_builtin.lsp_incoming_calls,
                { desc = "Incoming Calls" })
            vim.keymap.set("n", "<Leader>gO", telescope_builtin.lsp_outgoing_calls,
                { desc = "Outgoing Calls" })
            vim.keymap.set("n", "<Leader>cs", vim.lsp.buf.signature_help, { desc = "Signature Help" })
            vim.keymap.set("n", "<Leader>gs", telescope_builtin.lsp_document_symbols,
                { desc = "Symbols" })
            -- vim.keymap.set("n", "<Leader>gm",
            --     telescope_builtin.lsp_document_symbols( {symbols = { 'method', 'function' } } ),
            --     { desc = "Methods" })
            vim.keymap.set("n", "<Leader>cd", telescope_builtin.diagnostics,
                { desc = "Diagnostics" })
            vim.keymap.set("n", "<Leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
            vim.keymap.set({ "n", "x" }, "<Leader>cf", vim.lsp.buf.format,
                { desc = "Format" })
            vim.keymap.set("n", "<Leader>cw", vim.diagnostic.open_float, { desc = "Diagnostics Float" })
        end,
    },
}
