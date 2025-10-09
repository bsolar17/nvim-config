return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    lazy = true,
    keys = {
        {
            mode = "n",
            "<Leader>cc",
            function()
                vim.cmd("CodeCompanionChat Toggle")
            end,
            desc = "Chat",
        },
        {
            mode = "v",
            "<Leader>ce",
            function()
                vim.cmd("CodeCompanion /explain")
            end,
            desc = "Explain",
        },
        {
            mode = "n",
            "<Leader>ce",
            function()
                vim.cmd("normal! V")
                vim.cmd("CodeCompanion /explain")
            end,
            desc = "Explain",
        },
    },
    opts = {
        strategies = {
            chat = {
                adapter = "copilot",
                model = "claude-sonnet-4.5",
                tools = {
                    opts = {
                        default_tools = {
                            "full_stack_dev",
                        },
                    },
                },
            },
            inline = {
                adapter = "copilot",
                model = "claude-sonnet-4.5",
            },
            cmd = {
                adapter = "copilot",
                model = "claude-sonnet-4.5",
            },
        },
        display = {
            chat = {
                intro_message = "",
            },
        },
    },
}
