return {
    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        event = { "InsertEnter", "CmdlineEnter" },
        opts = {},
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
