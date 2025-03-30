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
            auto_insert_mode = true,
        },
        config = function(_, opts)
            require("CopilotChat").setup(opts)
            vim.keymap.set("n", "<Leader>C", "<cmd>CopilotChatToggle<cr>", { desc = "Copilot" })
        end,
    },
}
