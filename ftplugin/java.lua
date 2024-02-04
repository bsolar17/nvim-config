local bundles = {
    vim.fn.glob("~/Projects/jdtls/artifacts/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1),
};
vim.list_extend(bundles, vim.split(vim.fn.glob("~/Projects/jdtls/artifacts/vscode-java-test/server/*.jar", 1), "\n"))
local config = {
    cmd = { "jdtls" },
    root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
    init_options = {
        bundles = bundles
    },
}
require("jdtls").start_or_attach(config)
