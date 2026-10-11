return {
    {
        "rcasia/neotest-java",
        ft = "java",
        dependencies = {
            "mfussenegger/nvim-jdtls",
            "mfussenegger/nvim-dap",
        },
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "rcasia/neotest-java",
        },
        keys = {
            {
                "<Leader>tn",
                function()
                    require("neotest").run.run()
                end,
                desc = "Run Nearest",
            },
            {
                "<Leader>tN",
                function()
                    require("neotest").run.run({ strategy = "dap" })
                end,
                desc = "Debug Nearest",
            },
            {
                "<Leader>tf",
                function()
                    require("neotest").run.run(vim.fn.expand("%"))
                end,
                desc = "Run File",
            },
            {
                "<Leader>tp",
                function()
                    require("neotest").run.run(vim.fn.expand("%:p:h"))
                end,
                desc = "Run Package",
            },
            {
                "<Leader>ta",
                function()
                    require("neotest").run.run({ suite = true })
                end,
                desc = "Run All",
            },
            {
                "<Leader>tL",
                function()
                    require("neotest").run.run_last()
                end,
                desc = "Run Last",
            },
            {
                "<Leader>tS",
                function()
                    require("neotest").run.stop()
                end,
                desc = "Stop",
            },
            {
                "<Leader>ts",
                function()
                    require("neotest").summary.toggle()
                end,
                desc = "Summary",
            },
            {
                "<Leader>to",
                function()
                    require("neotest").output.open({ enter = true })
                end,
                desc = "Output",
            },
            {
                "<Leader>tO",
                function()
                    require("neotest").output_panel.toggle()
                end,
                desc = "Output Panel",
            },
            {
                "]t",
                function()
                    require("neotest").jump.next({ status = "failed" })
                end,
                desc = "Next Failed Test",
            },
            {
                "[t",
                function()
                    require("neotest").jump.prev({ status = "failed" })
                end,
                desc = "Previous Failed Test",
            },
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-java")(),
                },
            })
        end,
    },
}
