return {
    {
        "williamboman/mason.nvim",
        lazy = true,
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
                    if server_name == "jdtls" then
                        local config = {}
                        local formatter_config = os.getenv("JDTLS_FORMATTER_CONFIG")
                        if formatter_config and vim.fn.filereadable(formatter_config) == 1 then
                            config = {
                                settings = {
                                    java = {
                                        format = {
                                            settings = {
                                                url = formatter_config,
                                            },
                                        },
                                    },
                                },
                            }
                        end
                        require("lspconfig")[server_name].setup(config)
                    else
                        vim.lsp.enable(server_name)
                    end
                end
            }
        }
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "nvim-java/nvim-java",
            "ibhagwan/fzf-lua",
            "saghen/blink.cmp",
        },
        config = function()
            vim.lsp.config("*", require("blink.cmp").get_lsp_capabilities())
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
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if (client.name == "jdtls") then
                        local java = require("java")
                        vim.keymap.set("n", "<Leader>wb", function() java.build.build_workspace() end,
                            { desc = "Build", buffer = true })
                        vim.keymap.set("n", "<Leader>wc", function() java.build.clean_workspace() end,
                            { desc = "Clean", buffer = true })
                        vim.keymap.set("n", "<Leader>ra", function() java.runner.built_in.run_app({}) end,
                            { desc = "App", buffer = true })
                        vim.keymap.set("n", "<Leader>rs", function() java.runner.built_in.stop_app() end,
                            { desc = "Stop", buffer = true })
                        vim.keymap.set("n", "<Leader>rl", function() java.runner.built_in.toggle_logs() end,
                            { desc = "Logs", buffer = true })
                        vim.keymap.set("n", "<Leader>tc", function() java.test.run_current_class() end,
                            { desc = "Class", buffer = true })
                        vim.keymap.set("n", "<Leader>tm", function() java.test.run_current_method() end,
                            { desc = "Method", buffer = true })
                        vim.keymap.set("n", "<Leader>tr", function() java.test.view_last_report() end,
                            { desc = "Report", buffer = true })
                        vim.keymap.set("n", "<Leader>tdc", function() java.test.debug_current_class() end,
                            { desc = "Class", buffer = true })
                        vim.keymap.set("n", "<Leader>tdm", function() java.test.debug_current_method() end,
                            { desc = "Method", buffer = true })
                        vim.keymap.set("n", "<Leader>xv", function() java.refactor.extract_variable() end,
                            { desc = "Variable", buffer = true })
                        vim.keymap.set("n", "<Leader>xa", function() java.refactor.extract_variable_all_occurrence() end,
                            { desc = "Variable All", buffer = true })
                        vim.keymap.set("n", "<Leader>xc", function() java.refactor.extract_constant() end,
                            { desc = "Constant", buffer = true })
                        vim.keymap.set("n", "<Leader>xf", function() java.refactor.extract_field() end,
                            { desc = "Field", buffer = true })
                        vim.keymap.set("n", "<Leader>xm", function() java.refactor.extract_method() end,
                            { desc = "Method", buffer = true })
                    end
                end,
            })
        end,
    },
}
