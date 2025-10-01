return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        {
            mode = "n",
            "<Leader>cc",
            "<cmd>CodeCompanionChat Toggle<cr>",
            desc = "Chat",
        },
        {
            mode = "v",
            "<Leader>ce",
            "<cmd>CodeCompanion /explain<cr>",
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
                model = "claude-sonnet-4",
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
                model = "claude-sonnet-4",
            },
            cmd = {
                adapter = "copilot",
                model = "claude-sonnet-4",
            },
        },
        display = {
            chat = {
                intro_message = "",
            },
        },
    },
}
