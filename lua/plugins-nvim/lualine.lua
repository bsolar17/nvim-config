return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-mini/mini.nvim",
    },
    opts = {
        options = {
            globalstatus = true,
        },
        sections = {
            lualine_x = {
                {
                    "harpoon2",
                    icon = "",
                    separator = " ",
                },
                "encoding",
                "fileformat",
                "filetype",
            },
        },
    },
}
