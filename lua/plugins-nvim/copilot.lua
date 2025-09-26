return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
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
}
