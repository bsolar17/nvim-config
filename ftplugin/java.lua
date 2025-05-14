if vim.fn.executable("jdtls") == 1 then
    local path_to_mason_share = os.getenv("MASON") .. "/share"
    local path_to_java_debug = path_to_mason_share .. "/java-debug-adapter"
    local path_to_java_test = path_to_mason_share .. "/java-test"
    local path_to_lombok = path_to_mason_share .. "/jdtls/lombok.jar"
    local bundles = {
        vim.fn.glob(path_to_java_debug .. "/com.microsoft.java.debug.plugin.jar", true),
    }
    vim.list_extend(bundles, vim.split(vim.fn.glob(path_to_java_test .. "/*.jar", true), "\n"))
    local config = {
        cmd = vim.fn.filereadable(path_to_lombok) == 1
            and { "jdtls", "--jvm-arg=-javaagent:" .. path_to_lombok }
            or { "jdtls" },
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
