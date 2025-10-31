return {
    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        opts = {
            suggestion = {
                enabled = false
            },
            panel = {
                enabled = false
            },
        },
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "ravitemer/codecompanion-history.nvim",
        },
        lazy = true,
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
                    model = "claude-sonnet-4.5",
                    tools = {
                        opts = {
                            default_tools = {
                                "full_stack_dev",
                            },
                        },
                    },
                    slash_commands = {
                        ["buffer"] = {
                            keymaps = {
                                modes = {
                                    i = "<C-b>",
                                    n = "<C-b>",
                                },
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
            memory = {
                opts = {
                    chat = {
                        enabled = true,
                    },
                },
            },
            extensions = {
                history = {
                    enabled = true,
                },
            },
        },
    },
}
