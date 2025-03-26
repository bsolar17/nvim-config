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
            "ibhagwan/fzf-lua",
        },
        config = function()
            local fzf = require("fzf-lua")
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
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                vim.lsp.handlers.hover, { border = "rounded" }
            )
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers.signature_help, { border = "rounded" }
            )
            vim.diagnostic.config {
                float = { border = "rounded" },
            }
            vim.keymap.set({ "v", "n" }, "<Leader>ca", fzf.lsp_code_actions, { desc = "Actions" })
            vim.keymap.set("n", "<Leader>ch", vim.lsp.buf.hover, { desc = "Hover" })
            vim.keymap.set("n", "<Leader>gd", fzf.lsp_definitions,
                { desc = "Definitions" })
            vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration, { desc = "Declaration" })
            vim.keymap.set("n", "<Leader>gi", fzf.lsp_implementations,
                { desc = "Implementations" })
            vim.keymap.set("n", "<Leader>gt", fzf.lsp_typedefs,
                { desc = "Type Definitions" })
            vim.keymap.set("n", "<Leader>gr", fzf.lsp_references,
                { desc = "References" })
            vim.keymap.set("n", "<Leader>gI", fzf.lsp_incoming_calls,
                { desc = "Incoming Calls" })
            vim.keymap.set("n", "<Leader>gO", fzf.lsp_outgoing_calls,
                { desc = "Outgoing Calls" })
            vim.keymap.set("n", "<Leader>cs", vim.lsp.buf.signature_help, { desc = "Signature Help" })
            vim.keymap.set("n", "<Leader>gs", fzf.lsp_document_symbols,
                { desc = "Document Symbols" })
            vim.keymap.set("n", "<Leader>gS", fzf.lsp_workspace_symbols,
                { desc = "Workspace Symbols" })
            vim.keymap.set("n", "<Leader>gw", fzf.diagnostics_document,
                { desc = "Diagnostics Document" })
            vim.keymap.set("n", "<Leader>gW", fzf.diagnostics_workspace,
                { desc = "Diagnostics Workspace" })
            vim.keymap.set("n", "<Leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
            vim.keymap.set({ "n", "x" }, "<Leader>cf", vim.lsp.buf.format,
                { desc = "Format" })
            vim.keymap.set("n", "<Leader>cw", vim.diagnostic.open_float, { desc = "Diagnostics Float" })
        end,
    },
}
