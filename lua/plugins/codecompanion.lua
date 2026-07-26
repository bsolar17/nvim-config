return {
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
            adapters = {
                acp = {
                    claude_code = function()
                        return require("codecompanion.adapters").extend(
                            "claude_code",
                            {
                                env = {
                                    CLAUDE_CODE_OAUTH_TOKEN = "${CLAUDE_CODE_OAUTH_TOKEN_ACP}",
                                },
                            }
                        )
                    end,
                },
            },
            interactions = {
                chat = {
                    adapter = "claude_code",
                    tools = {
                        opts = {
                            default_tools = {
                                "agent",
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
            },
            display = {
                chat = {
                    intro_message = "",
                    fold_reasoning = false,
                },
            },
            extensions = {
                history = {
                    enabled = true,
                    opts = {
                        auto_generate_title = false,
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
