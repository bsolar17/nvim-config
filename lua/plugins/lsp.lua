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
                    vim.keymap.set("n", "<Leader>gS", fzf.lsp_workspace_symbols,
                        { desc = "Workspace Symbols", buffer = true })
                    vim.keymap.set("n", "<Leader>gw", fzf.diagnostics_document,
                        { desc = "Diagnostics Document", buffer = true })
                    vim.keymap.set("n", "<Leader>gW", fzf.diagnostics_workspace,
                        { desc = "Diagnostics Workspace", buffer = true })
                    vim.keymap.set("n", "<Leader>cr", vim.lsp.buf.rename, { desc = "Rename", buffer = true })
                    vim.keymap.set({ "n", "x" }, "<Leader>cf", vim.lsp.buf.format,
                        { desc = "Format", buffer = true })
                    vim.keymap.set("n", "<Leader>cw", vim.diagnostic.open_float, { desc = "Diagnostics Float" })
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if (client.name == "jdtls") then
                        vim.keymap.set("n", "<Leader>wb", "<cmd>lua require('java').build.build_workspace()<cr>",
                            { desc = "Build", buffer = true })
                        vim.keymap.set("n", "<Leader>wc", "<cmd>lua require('java').build.clean_workspace()<cr>",
                            { desc = "Clean", buffer = true })
                        vim.keymap.set("n", "<Leader>ra", "<cmd>lua require('java').runner.built_in.run_app({})<cr>",
                            { desc = "App", buffer = true })
                        vim.keymap.set("n", "<Leader>rs", "<cmd>lua require('java').runner.built_in.stop_app()<cr>",
                            { desc = "Stop", buffer = true })
                        vim.keymap.set("n", "<Leader>rl", "<cmd>lua require('java').runner.built_in.toggle_logs()<cr>",
                            { desc = "Logs", buffer = true })
                        vim.keymap.set("n", "<Leader>tc", "<cmd>lua require('java').test.run_current_class()<cr>",
                            { desc = "Class", buffer = true })
                        vim.keymap.set("n", "<Leader>tm", "<cmd>lua require('java').test.run_current_method()<cr>",
                            { desc = "Method", buffer = true })
                        vim.keymap.set("n", "<Leader>tr", "<cmd>lua require('java').test.view_last_report()<cr>",
                            { desc = "Report", buffer = true })
                        vim.keymap.set("n", "<Leader>tdc", "<cmd>lua require('java').test.debug_current_class()<cr>",
                            { desc = "Class", buffer = true })
                        vim.keymap.set("n", "<Leader>tdm", "<cmd>lua require('java').test.debug_current_method()<cr>",
                            { desc = "Method", buffer = true })
                        vim.keymap.set("n", "<Leader>xv", "<cmd>lua require('java').refactor.extract_variable()<cr>",
                            { desc = "Variable", buffer = true })
                        vim.keymap.set("n", "<Leader>xa",
                            "<cmd>lua require('java').refactor.extract_variable_all_occurrence()<cr>",
                            { desc = "Variable All", buffer = true })
                        vim.keymap.set("n", "<Leader>xc", "<cmd>lua require('java').refactor.extract_constant()<cr>",
                            { desc = "Constant", buffer = true })
                        vim.keymap.set("n", "<Leader>xf", "<cmd>lua require('java').refactor.extract_field()<cr>",
                            { desc = "Field", buffer = true })
                        vim.keymap.set("n", "<Leader>xm", "<cmd>lua require('java').refactor.extract_method()<cr>",
                            { desc = "Method", buffer = true })
                    end
                end,
            })
        end,
    },
}
