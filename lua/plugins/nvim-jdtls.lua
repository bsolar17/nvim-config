local root_markers = { "gradlew", ".git", "mvnw" }
local function get_root_dir(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, root_markers) or vim.fn.getcwd())
end

local function get_mason_share()
    local mason = vim.env.MASON
        or vim.fs.joinpath(vim.fn.stdpath("data"), "mason")
    return vim.fs.joinpath(mason, "share")
end

local function get_cmd()
    local path_to_lombok =
        vim.fs.joinpath(get_mason_share(), "jdtls", "lombok.jar")
    local cache_home = vim.env.XDG_CACHE_HOME or vim.fn.stdpath("cache")
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir =
        vim.fs.joinpath(cache_home, "jdtls", "workspace", project_name)
    local cmd = { "jdtls", "-data", workspace_dir }
    if vim.fn.filereadable(path_to_lombok) == 1 then
        table.insert(cmd, 2, "--jvm-arg=-javaagent:" .. path_to_lombok)
    end
    return cmd
end

local function get_java_major_versions(java_installs_dir)
    local major_versions = {}
    if vim.fn.isdirectory(java_installs_dir) == 1 then
        for _, entry in ipairs(vim.fn.readdir(java_installs_dir)) do
            if entry:match("^%d+$") then
                table.insert(major_versions, entry)
            end
        end
    end
    return major_versions
end

local function to_execution_environment_name(major_version)
    if tonumber(major_version) <= 8 then
        return "JavaSE-1." .. major_version
    end
    return "JavaSE-" .. major_version
end

local function get_runtimes()
    local data_home = vim.env.XDG_DATA_HOME
        or vim.fs.joinpath(vim.env.HOME, ".local", "share")
    local java_installs_dir =
        vim.fs.joinpath(data_home, "mise", "installs", "java")
    local runtimes = {}
    for _, major_version in ipairs(get_java_major_versions(java_installs_dir)) do
        table.insert(runtimes, {
            name = to_execution_environment_name(major_version),
            path = vim.fs.joinpath(java_installs_dir, major_version),
        })
    end
    return runtimes
end

local function get_settings()
    return {
        java = {
            configuration = {
                runtimes = get_runtimes(),
            },
            maven = {
                downloadSources = true,
            },
            codeGeneration = {
                addFinalForNewDeclaration = "all",
            },
        },
    }
end

local function get_bundles()
    local path_to_mason_share = get_mason_share()
    local path_to_java_debug =
        vim.fs.joinpath(path_to_mason_share, "java-debug-adapter")
    local path_to_java_test = vim.fs.joinpath(path_to_mason_share, "java-test")
    local bundles = {
        vim.fn.glob(
            vim.fs.joinpath(
                path_to_java_debug,
                "com.microsoft.java.debug.plugin-*.jar"
            ),
            1
        ),
    }
    local java_test_bundles = vim.split(
        vim.fn.glob(vim.fs.joinpath(path_to_java_test, "*.jar"), 1),
        "\n"
    )
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

local function get_formatter_config(root_dir)
    local from_env = vim.env.JDTLS_FORMATTER_CONFIG
    if from_env and vim.fn.filereadable(from_env) == 1 then
        return from_env
    end
    if root_dir then
        local from_root =
            vim.fs.joinpath(root_dir, ".eclipse-java-formatter.xml")
        if vim.fn.filereadable(from_root) == 1 then
            return from_root
        end
    end
end

-- `vim.lsp.config` resolves `settings` once, up front, when no project root is
-- known yet, so the root-dependent formatter config is applied per client.
local function set_formatter_config(client)
    local formatter_config = get_formatter_config(client.root_dir)
    if not formatter_config then
        return
    end
    client.settings = vim.tbl_deep_extend("force", client.settings, {
        java = {
            format = {
                settings = {
                    url = formatter_config,
                },
            },
        },
    })
    client:notify(
        "workspace/didChangeConfiguration",
        { settings = client.settings }
    )
end

-- `require("jdtls").start_or_attach` derives the indentation jdtls formats with
-- from the buffer; `vim.lsp.enable` does not, so mirror it here.
local function on_workspace_configuration(err, result, ctx, config)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if client then
        client.settings = vim.tbl_deep_extend("keep", client.settings, {
            java = {
                format = {
                    insertSpaces = vim.bo.expandtab,
                    tabSize = vim.lsp.util.get_effective_tabstop(),
                },
            },
        })
    end
    return vim.lsp.handlers["workspace/configuration"](err, result, ctx, config)
end

return {
    {
        "mfussenegger/nvim-jdtls",
        lazy = true,
        ft = "java",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function()
            if vim.fn.executable("jdtls") ~= 1 then
                return
            end
            vim.lsp.config("jdtls", {
                cmd = get_cmd(),
                root_markers = root_markers,
                root_dir = get_root_dir,
                settings = get_settings(),
                init_options = {
                    bundles = get_bundles(),
                },
                handlers = {
                    ["workspace/configuration"] = on_workspace_configuration,
                },
                on_init = set_formatter_config,
            })
            vim.lsp.enable("jdtls")
        end,
    },
    {
        "JavaHello/spring-boot.nvim",
        lazy = true,
        ft = {
            "java",
            "yaml",
            "jproperties",
        },
        dependencies = {
            "mfussenegger/nvim-jdtls",
        },
        opts = {},
    },
}
