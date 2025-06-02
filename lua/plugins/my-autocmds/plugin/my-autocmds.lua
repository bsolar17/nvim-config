local function get_cmd(path_to_mason_share)
    local path_to_lombok = path_to_mason_share .. "/jdtls/lombok.jar"
    local cmd = vim.fn.filereadable(path_to_lombok) == 1
        and { "jdtls", "--jvm-arg=-javaagent:" .. path_to_lombok }
        or { "jdtls" }
    return cmd
end

local function get_settings()
    local settings = {
        java = {
            maven = {
                downloadSources = true,
            },
            codeGeneration = {
                addFinalForNewDeclaration = "all",
            },
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

local function get_bundles(path_to_mason_share)
    local path_to_java_debug = path_to_mason_share .. "/java-debug-adapter"
    local path_to_java_test = path_to_mason_share .. "/java-test"
    local bundles = {
        vim.fn.glob(path_to_java_debug .. "/com.microsoft.java.debug.plugin.jar", true),
    }
    vim.list_extend(bundles, vim.split(vim.fn.glob(path_to_java_test .. "/*.jar", true), "\n"))
    return bundles
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    callback = function()
        vim.g.editorconfig = false
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt.textwidth = 80
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "xml",
    callback = function()
        vim.api.nvim_command("filetype indent off")
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
        if vim.fn.executable("jdtls") == 1 then
            local path_to_mason_share = os.getenv("MASON") .. "/share"
            local config = {
                cmd = get_cmd(path_to_mason_share),
                root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
                settings = get_settings(),
                init_options = {
                    bundles = get_bundles(path_to_mason_share),
                },
            }
            require("jdtls").start_or_attach(config)
        end
    end,
})
