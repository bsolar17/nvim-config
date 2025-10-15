local function get_jdtls_cmd(path_to_mason_share)
    local path_to_lombok = path_to_mason_share .. "/jdtls/lombok.jar"
    local cmd = vim.fn.filereadable(path_to_lombok) == 1
        and { "jdtls", "--jvm-arg=-javaagent:" .. path_to_lombok }
        or { "jdtls" }
    return cmd
end

local function get_jdtls_settings(path_to_mason_share)
    local path_to_java_debug = path_to_mason_share .. "/java-debug-adapter"
    local path_to_java_test = path_to_mason_share .. "/java-test"
    local bundles = {
        vim.fn.glob(path_to_java_debug .. "/com.microsoft.java.debug.plugin.jar", true),
    }
    local java_test_bundles = vim.split(vim.fn.glob(path_to_java_test .. "/*.jar", 1), "\n")
    local excluded = {
        "com.microsoft.java.test.runner-jar-with-dependencies.jar",
        "jacocoagent.jar",
    }
    for _, java_test_jar in ipairs(java_test_bundles) do
        local fname = vim.fn.fnamemodify(java_test_jar, ":t")
        if not vim.tbl_contains(excluded, fname) then
            table.insert(bundles, java_test_jar)
        end
    end
    vim.list_extend(bundles, require("spring_boot").java_extensions())
    local settings = {
        java = {
            maven = {
                downloadSources = true,
            },
            codeGeneration = {
                addFinalForNewDeclaration = "all",
            },
            initializationOptions = {
                bundles = bundles,
            }
        }
    }
    local jdtls_formatter_config = os.getenv("JDTLS_FORMATTER_CONFIG")
    if jdtls_formatter_config and vim.fn.filereadable(jdtls_formatter_config) == 1 then
        settings.java.format = {
            settings = {
                url = jdtls_formatter_config,
            },
        }
    end
    return settings
end

local function setup_general_keymaps()
    local fzf = require("fzf-lua")
    vim.keymap.set(
        { "v", "n", buffer = true },
        "<Leader>ca",
        fzf.lsp_code_actions,
        { desc = "Actions" }
    )
    vim.keymap.set(
        "n",
        "<Leader>ch",
        vim.lsp.buf.hover,
        { desc = "Hover", buffer = true }
    )
    vim.keymap.set(
        "n",
        "<Leader>gd",
        fzf.lsp_definitions,
        { desc = "Definitions", buffer = true }
    )
    vim.keymap.set(
        "n",
        "<Leader>gD",
        vim.lsp.buf.declaration,
        { desc = "Declaration", buffer = true }
    )
    vim.keymap.set(
        "n",
        "<Leader>gi",
        fzf.lsp_implementations,
        { desc = "Implementations", buffer = true }
    )
    vim.keymap.set(
        "n",
        "<Leader>gt",
        fzf.lsp_typedefs,
        { desc = "Type Definitions", buffer = true }
    )
    vim.keymap.set(
        "n",
        "<Leader>gr",
        fzf.lsp_references,
        { desc = "References", buffer = true }
    )
    vim.keymap.set(
        "n",
        "<Leader>gI",
        fzf.lsp_incoming_calls,
        { desc = "Incoming Calls", buffer = true }
    )
    vim.keymap.set(
        "n",
        "<Leader>gO",
        fzf.lsp_outgoing_calls,
        { desc = "Outgoing Calls", buffer = true }
    )
    vim.keymap.set(
        "n",
        "<Leader>cs",
        vim.lsp.buf.signature_help,
        { desc = "Signature Help", buffer = true }
    )
    vim.keymap.set(
        "n",
        "<Leader>gs",
        fzf.lsp_document_symbols,
        { desc = "Document Symbols", buffer = true }
    )
    vim.keymap.set(
        "n",
        "<Leader>gm",
        function()
            fzf.lsp_document_symbols(
                {
                    regex_filter = function(item, _)
                        return item.kind == "Method" or item.kind == "Function"
                    end
                }
            )
        end,
        { desc = "Document Methods", buffer = true }
    )
    vim.keymap.set(
        "n",
        "<Leader>gS",
        fzf.lsp_live_workspace_symbols,
        { desc = "Workspace Symbols", buffer = true }
    )
    vim.keymap.set(
        "n",
        "<Leader>gw",
        fzf.diagnostics_document,
        { desc = "Diagnostics Document", buffer = true }
    )
    vim.keymap.set(
        "n",
        "<Leader>gW",
        fzf.diagnostics_workspace,
        { desc = "Diagnostics Workspace", buffer = true }
    )
    vim.keymap.set(
        "n",
        "<Leader>cr",
        vim.lsp.buf.rename,
        { desc = "Rename", buffer = true }
    )
    vim.keymap.set(
        "n",
        "<Leader>cw",
        vim.diagnostic.open_float,
        { desc = "Diagnostics Float" }
    )
end

local function setup_java_keymaps()
    local jdtls = require("jdtls")
    vim.keymap.set(
        "n",
        "<leader>co",
        function() jdtls.organize_imports() end,
        { buffer = buffer, desc = "Organize Imports" }
    )
    vim.keymap.set(
        "n",
        "<leader>tc",
        function() jdtls.test_class() end,
        { buffer = buffer, desc = "Test Class" }
    )
    vim.keymap.set(
        "n",
        "<leader>tm",
        function() jdtls.test_nearest_method() end,
        { buffer = buffer, desc = "Test Nearest Method" }
    )
    vim.keymap.set(
        "v",
        "<leader>xv",
        "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
        { buffer = buffer, desc = "Extract Variable" }
    )
    vim.keymap.set(
        "n",
        "<leader>xv",
        function() jdtls.extract_variable() end,
        { buffer = buffer, desc = "Extract Variable" }
    )
    vim.keymap.set(
        "v",
        "<leader>xc",
        "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
        { buffer = buffer, desc = "Extract Constant" }
    )
    vim.keymap.set(
        "n",
        "<leader>xc",
        function() jdtls.extract_constant() end,
        { buffer = buffer, desc = "Extract Variable" }
    )
    vim.keymap.set(
        "v",
        "<leader>xm",
        "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
        { buffer = buffer, desc = "Extract Method" }
    )
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
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "ibhagwan/fzf-lua",
            "mason-org/mason-lspconfig.nvim",
            "mfussenegger/nvim-jdtls",
        },
        config = function()
            if vim.fn.executable("jdtls") == 1 then
                local path_to_mason_share = os.getenv("MASON") .. "/share"
                vim.lsp.config("jdtls", {
                    cmd = get_jdtls_cmd(path_to_mason_share),
                    settings = get_jdtls_settings(path_to_mason_share),
                })
            end
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP attach",
                callback = function(event)
                    setup_general_keymaps()
                    if vim.lsp.get_client_by_id(event.data.client_id).name == "jdtls" then
                        setup_java_keymaps()
                    end
                end,
            })
        end,
    },
}
