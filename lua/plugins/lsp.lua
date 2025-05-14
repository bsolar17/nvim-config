local function setup_general_keymaps()
    local fzf = require("fzf-lua")
    vim.keymap.set({ "v", "n", buffer = true }, "<Leader>ca", fzf.lsp_code_actions, { desc = "Actions" })
    vim.keymap.set("n", "<Leader>ch", vim.lsp.buf.hover, { desc = "Hover", buffer = true })
    vim.keymap.set("n", "<Leader>gd", fzf.lsp_definitions,
        { desc = "Definitions", buffer = true })
    vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration, { desc = "Declaration", buffer = true })
    vim.keymap.set("n", "<Leader>gi", fzf.lsp_implementations,
        { desc = "Implementations", buffer = true })
    vim.keymap.set("n", "<Leader>gt", fzf.lsp_typedefs,
        { desc = "Type Definitions", buffer = true })
    vim.keymap.set("n", "<Leader>gr", fzf.lsp_references,
        { desc = "References", buffer = true })
    vim.keymap.set("n", "<Leader>gI", fzf.lsp_incoming_calls,
        { desc = "Incoming Calls", buffer = true })
    vim.keymap.set("n", "<Leader>gO", fzf.lsp_outgoing_calls,
        { desc = "Outgoing Calls", buffer = true })
    vim.keymap.set("n", "<Leader>cs", vim.lsp.buf.signature_help,
        { desc = "Signature Help", buffer = true })
    vim.keymap.set("n", "<Leader>gs", fzf.lsp_document_symbols,
        { desc = "Document Symbols", buffer = true })
    vim.keymap.set("n", "<Leader>gm",
        function()
            fzf.lsp_document_symbols(
                {
                    regex_filter = function(item, _)
                        return item.kind == "Method" or item.kind == "Function"
                    end
                }
            )
        end,
        { desc = "Document Methods", buffer = true })
    vim.keymap.set("n", "<Leader>gS", fzf.lsp_workspace_symbols,
        { desc = "Workspace Symbols", buffer = true })
    vim.keymap.set("n", "<Leader>gw", fzf.diagnostics_document,
        { desc = "Diagnostics Document", buffer = true })
    vim.keymap.set("n", "<Leader>gW", fzf.diagnostics_workspace,
        { desc = "Diagnostics Workspace", buffer = true })
    vim.keymap.set("n", "<Leader>cr", vim.lsp.buf.rename, { desc = "Rename", buffer = true })
    vim.keymap.set("n", "<Leader>cw", vim.diagnostic.open_float, { desc = "Diagnostics Float" })
end

return {
    {
        "mason-org/mason.nvim",
        lazy = true,
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = true,
        opts = {
            automatic_installation = true,
            handlers = {
                function(server_name)
                    vim.lsp.enable(server_name)
                end
            }
        }
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "ibhagwan/fzf-lua",
            "saghen/blink.cmp",
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            vim.lsp.config("*", require("blink.cmp").get_lsp_capabilities())
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP attach",
                callback = function(event)
                    setup_general_keymaps()
                end,
            })
        end,
    },
}
