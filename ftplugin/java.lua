if vim.fn.executable("jdtls") == 1 then
    -- local bundles = {
    --     vim.fn.glob("${XDG_DATA_HOME}/jdtls/java-debug/*.jar", 1),
    -- };
    -- vim.list_extend(bundles, vim.split(vim.fn.glob("${XDG_DATA_HOME}/jdtls/vscode-java-test/*.jar", 1), "\n"))
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
        -- init_options = {
        --     bundles = bundles
        -- },
    }
    require("jdtls").start_or_attach(config)
end
