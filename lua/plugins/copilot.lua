return {
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
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
