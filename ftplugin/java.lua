if vim.fn.executable("jdtls") == 1 then
    local path_to_mason_packages = os.getenv("XDG_DATA_HOME") .. "/nvim/mason/packages"
    local path_to_java_debug = path_to_mason_packages .. "/java-debug-adapter"
    local path_to_java_test = path_to_mason_packages .. "/java-test"
    local bundles = {
        vim.fn.glob(path_to_java_debug .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
    }
    vim.list_extend(bundles, vim.split(vim.fn.glob(path_to_java_test .. "/extension/server/*.jar", true), "\n"))
    local config = {
        cmd = { "jdtls" },
        root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
        settings = {
            java = {
                maven = {
                    downloadSources = true,
                },
            }
        },
        init_options = {
            bundles = bundles
        },
    }
    require("jdtls").start_or_attach(config)
end
