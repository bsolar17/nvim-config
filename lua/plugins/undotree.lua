return {
    "jiaoshijie/undotree",
    lazy = false,
    opts = {},
    keys = {
        {
            "<leader>u",
            function()
                require("undotree").toggle()
            end,
            { desc = "Undotree" },
        },
    },
}
