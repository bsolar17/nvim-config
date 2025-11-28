return {
    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        opts = {
            suggestion = {
                enabled = false,
            },
            panel = {
                enabled = false,
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
                "<Cmd>CodeCompanionChat Toggle<CR>",
                desc = "Chat",
            },
            {
                mode = "v",
                "<Leader>ce",
                "<Cmd>CodeCompanion /explain<CR>",
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
                    adapter = {
                        name = "copilot",
                        model = "claude-opus-4.5",
                    },
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
                    adapter = {
                        name = "copilot",
                    },
                },
                cmd = {
                    adapter = {
                        name = "copilot",
                    },
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
                        enabled = false,
                    },
                },
            },
            extensions = {
                history = {
                    enabled = true,
                    opts = {
                        title_generation_opts = {
                            model = "gpt-4.1",
                            summary = {
                                generation_opts = {
                                    model = "gpt-4.1",
                                },
                            },
                        },
                    },
                },
            },
        },
    },
}
