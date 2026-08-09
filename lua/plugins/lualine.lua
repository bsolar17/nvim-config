require("lualine").setup({
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
})
