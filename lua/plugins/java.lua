return {
    "nvim-java/nvim-java",
    opts = {
        jdk = {
            auto_install = false,
        },
        notifications = {
            dap = false,
        },
    },
    config = function(_, opts)
        require("java").setup(opts)
        vim.keymap.set("n", "<Leader>wb", "<cmd>lua require('java').build.build_workspace()<cr>", { desc = "Build" })
        vim.keymap.set("n", "<Leader>wc", "<cmd>lua require('java').build.clean_workspace()<cr>", { desc = "Clean" })
        vim.keymap.set("n", "<Leader>ar", "<cmd>lua require('java').runner.built_in.run_app()<cr>", { desc = "Run" })
        vim.keymap.set("n", "<Leader>as", "<cmd>lua require('java').runner.built_in.stop_app()<cr>", { desc = "Stop" })
        vim.keymap.set("n", "<Leader>al", "<cmd>lua require('java').runner.built_in.toggle_logs()<cr>", { desc = "Logs" })
        vim.keymap.set("n", "<Leader>tc", "<cmd>lua require('java').test.run_current_class()<cr>", { desc = "Class" })
        vim.keymap.set("n", "<Leader>tm", "<cmd>lua require('java').test.run_current_method()<cr>", { desc = "Method" })
        vim.keymap.set("n", "<Leader>tr", "<cmd>lua require('java').test.view_last_report()<cr>", { desc = "Report" })
        vim.keymap.set("n", "<Leader>tdc", "<cmd>lua require('java').test.debug_current_class()<cr>", { desc = "Class" })
        vim.keymap.set("n", "<Leader>tdm", "<cmd>lua require('java').test.debug_current_method()<cr>",
            { desc = "Method" })
        vim.keymap.set("n", "<Leader>xv", "<cmd>lua require('java').refactor.extract_variable()<cr>",
            { desc = "Variable" })
        vim.keymap.set("n", "<Leader>xa", "<cmd>lua require('java').refactor.extract_variable_all_occurrence()<cr>",
            { desc = "Variable All" })
        vim.keymap.set("n", "<Leader>xc", "<cmd>lua require('java').refactor.extract_constant()<cr>",
            { desc = "Constant" })
        vim.keymap.set("n", "<Leader>xf", "<cmd>lua require('java').refactor.extract_field()<cr>", { desc = "Field" })
        vim.keymap.set("n", "<Leader>xm", "<cmd>lua require('java').refactor.extract_method()<cr>", { desc = "Method" })
    end,
}
