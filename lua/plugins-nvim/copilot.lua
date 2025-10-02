return {
    {
        "ravitemer/mcphub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        build = "bundled_build.lua",
        opts = {
            use_bundled_binary = true,
        }
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "ravitemer/mcphub.nvim",
        },
        lazy = false,
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
                                "neovim",
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
            extensions = {
                mcphub = {
                    callback = "mcphub.extensions.codecompanion",
                    opts = {
                        make_tools = true,
                        show_server_tools_in_chat = true,
                        add_mcp_prefix_to_tool_names = false,
                        show_result_in_chat = true,
                        format_tool = nil,
                        make_vars = true,
                        make_slash_commands = true,
                    }
                }
            }
        },
    },
}
