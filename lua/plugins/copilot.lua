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
}
