local main_adapter = "copilot"
local main_model = "gpt-4.1"
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
            "nvim-treesitter/nvim-treesitter",
            "ravitemer/codecompanion-history.nvim",
            "lalitmee/codecompanion-spinners.nvim",
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
            interactions = {
                chat = {
                    adapter = {
                        name = main_adapter,
                        model = main_model,
                    },
                    keymaps = {
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
                        model = main_model,
                    },
                },
                cmd = {
                    adapter = {
                        name = "copilot",
                        model = main_model,
                    },
                },
                background = {
                    adapter = {
                        name = "copilot",
                        model = main_model,
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
                            adapter = "copilot",
                            model = main_model,
                            summary = {
                                generation_opts = {
                                    adapter = "copilot",
                                    model = main_model,
                                },
                                create_summary_keymap = "gSc",
                                browse_summaries_keymap = "gSb",
                            },
                        },
                    },
                },
                spinner = {
                    opts = {
                        style = "fidget",
                    },
                },
            },
        },
    },
}
