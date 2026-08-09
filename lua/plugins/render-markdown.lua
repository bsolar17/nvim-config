require("render-markdown").setup({
    completions = {
        blink = {
            enabled = true,
        },
    },
    heading = {
        icons = {
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
        },
        position = "overlay",
        backgrounds = {},
    },
    code = {
        border = "thin",
    },
    win_options = {
        conceallevel = {
            rendered = 0,
        },
    },
})
