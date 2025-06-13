return {
    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        event = { "InsertEnter", "CmdlineEnter" },
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" },
        },
        build = "make tiktoken",
        opts = {
            model = "claude-sonnet-4",
        },
        config = function(_, opts)
            require("CopilotChat").setup(opts)
            vim.keymap.set(
                "n",
                "<Leader>C",
                "<cmd>CopilotChatToggle<cr>",
                { desc = "Copilot" }
            )
            vim.keymap.set(
                "v",
                "<Leader>ce",
                "<cmd>CopilotChatExplain<cr>",
                { desc = "Explain" }
            )
            vim.keymap.set(
                "n",
                "<Leader>ce",
                function()
                    vim.cmd("normal! V")
                    vim.cmd("CopilotChatExplain")
                end,
                { desc = "Explain" }
            )
        end,
    },
}
