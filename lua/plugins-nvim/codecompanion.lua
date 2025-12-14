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
        build = "npm install -g mcp-hub@latest",
        opts = {
            on_ready = function(hub)
                vim.notify("MCPHub ready")
            end,
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
                    adapter = "copilot",
                    keymaps = {
                        toggle_model = {
                            modes = { n = "gm" },
                            description = "Toggle Model",
                            callback = function(chat)
                                local preferred_models = {
                                    "gpt-4.1",
                                    "claude-sonnet-4.5",
                                    "claude-opus-4.5",
                                }
                                local current_model =
                                    chat.adapter.schema.model.default
                                local next_model = preferred_models[1]
                                for i, m in ipairs(preferred_models) do
                                    if m == current_model then
                                        next_model =
                                            preferred_models[i % #preferred_models + 1]
                                        break
                                    end
                                end
                                chat:apply_model(next_model)
                                vim.notify("Switched to " .. next_model)
                            end,
                        },
                        load_mcphub = {
                            modes = { n = "gH" },
                            description = "Load MCPHub",
                            callback = function()
                                if
                                    require("lazy.core.config").plugins["mcphub.nvim"]._.loaded
                                then
                                    vim.notify("MCPHub already loaded")
                                else
                                    require("lazy").load({
                                        plugins = { "mcphub.nvim" },
                                    })
                                    require("codecompanion").register_extension(
                                        "mcphub",
                                        {
                                            setup = function()
                                                require(
                                                    "mcphub.extensions.codecompanion"
                                                ).setup({
                                                    make_vars = true,
                                                    make_slash_commands = true,
                                                    show_result_in_chat = true,
                                                })
                                            end,
                                        }
                                    )
                                end
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
            },
        },
    },
}
