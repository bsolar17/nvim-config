local function get_cmd(path_to_mason_share)
    local path_to_lombok = path_to_mason_share .. "/jdtls/lombok.jar"
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = os.getenv("XDG_CACHE_HOME")
        .. "/jdtls/workspace/"
        .. project_name
    local cmd = vim.fn.filereadable(path_to_lombok) == 1
            and {
                "jdtls",
                "--jvm-arg=-javaagent:" .. path_to_lombok,
                "-data",
                workspace_dir,
            }
        or { "jdtls", "-data", workspace_dir }
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
        },
    }
    local jdtls_formatter_config = os.getenv("JDTLS_FORMATTER_CONFIG")
    if
        not jdtls_formatter_config
        or vim.fn.filereadable(jdtls_formatter_config) ~= 1
    then
        local root_dir = vim.fs.root(0, { "gradlew", ".git", "mvnw" })
        if root_dir then
            local formatter_path = root_dir .. "/.eclipse-java-formatter.xml"
            if vim.fn.filereadable(formatter_path) == 1 then
                jdtls_formatter_config = formatter_path
            end
        end
    end
    if
        jdtls_formatter_config
        and vim.fn.filereadable(jdtls_formatter_config) == 1
    then
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
        vim.fn.glob(
            path_to_java_debug .. "/com.microsoft.java.debug.plugin-*.jar",
            1
        ),
    }
    local java_test_bundles =
        vim.split(vim.fn.glob(path_to_java_test .. "/*.jar", 1), "\n")
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
    return bundles
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
        if vim.fn.executable("jdtls") == 1 then
            local path_to_mason_share = os.getenv("MASON") .. "/share"
            local config = {
                name = "jdtls",
                cmd = get_cmd(path_to_mason_share),
                root_dir = vim.fs.root(0, { "gradlew", ".git", "mvnw" }),
                settings = get_settings(),
                init_options = {
                    bundles = get_bundles(path_to_mason_share),
                },
            }
            require("jdtls").start_or_attach(config)
        end
    end,
})
