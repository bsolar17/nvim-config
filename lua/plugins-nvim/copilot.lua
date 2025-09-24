return {
    {
        "ravitemer/mcphub.nvim",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        build = "bundled_build.lua",
        config = function()
            require("mcphub").setup({
                use_bundled_binary = true,
            })
        end,
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "ravitemer/mcphub.nvim",
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
                                "neovim",
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
            extensions = {
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
        config = function(_, opts)
            require("codecompanion").setup(opts)
            vim.keymap.set(
                "n",
                "<Leader>cc",
                "<cmd>CodeCompanionChat Toggle<cr>",
                { desc = "Chat" }
            )
            vim.keymap.set(
                "v",
                "<Leader>ce",
                "<cmd>CodeCompanion /explain<cr>",
                { desc = "Explain" }
            )
            vim.keymap.set(
                "n",
                "<Leader>ce",
                function()
                    vim.cmd("normal! V")
                    vim.cmd("CodeCompanion /explain")
                end,
                { desc = "Explain" }
            )
        end,
    },
}
