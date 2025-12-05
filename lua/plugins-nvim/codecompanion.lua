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
        "ravitemer/mcphub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        lazy = true,
        build = "bundled_build.lua",
        opts = {
            use_bundled_binary = true,
        },
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "ravitemer/codecompanion-history.nvim",
            "ravitemer/mcphub.nvim",
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
            ignore_warnings = true,
            strategies = {
                chat = {
                    adapter = "copilot",
                    keymaps = {
                        toggle_model = {
                            modes = { n = "gm" },
                            description = "Toggle Model",
                            callback = function(chat)
                                local models = { "gpt-4.1", "claude-opus-4.5" }
                                local current =
                                    chat.adapter.schema.model.default
                                local next_model
                                if current == models[1] then
                                    next_model = models[2]
                                else
                                    next_model = models[1]
                                end
                                chat:apply_model(next_model)
                                vim.notify("Switched to " .. next_model)
                            end,
                        },
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
                                    n = "gb",
                                },
                            },
                        },
                    },
                },
                inline = {
                    adapter = {
                        name = "copilot",
                        model = "gpt-4.1",
                    },
                },
                cmd = {
                    adapter = {
                        name = "copilot",
                        model = "gpt-4.1",
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
                                create_summary_keymap = "gSc",
                                browse_summaries_keymap = "gSb",
                            },
                        },
                    },
                },
                mcphub = {
                    callback = "mcphub.extensions.codecompanion",
                    opts = {
                        make_vars = true,
                        make_slash_commands = true,
                        show_result_in_chat = true,
                    },
                },
            },
        },
    },
}
