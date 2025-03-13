return {
    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        event = { "InsertEnter", "CmdlineEnter" },
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
        config = function(_, opts)
            local copilot = require("copilot")
            copilot:setup()
            vim.cmd(":Copilot disable")
            vim.keymap.set("n", "<Leader>Ce", "<cmd>Copilot enable<cr>", { desc = "Enable" })
            vim.keymap.set("n", "<Leader>Cd", "<cmd>Copilot disable<cr>", { desc = "Disable" })
            vim.keymap.set("n", "<Leader>Cs", "<cmd>Copilot status<cr>", { desc = "Status" })
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        dependecies = {
            "zbirenbaum/copilot.lua",
        },
        event = "InsertEnter",
        opts = {
            fix_pairs = true,
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
        opts = {},
        config = function(_, opts)
            require("CopilotChat").setup(opts)
            vim.keymap.set("n", "<Leader>Cc", "<cmd>CopilotChatToggle<cr>", { desc = "Chat" })
        end,
    },
}
