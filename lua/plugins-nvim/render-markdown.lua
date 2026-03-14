return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-mini/mini.nvim",
    },
    ft = {
        "markdown",
        "codecompanion",
    },
    opts = {
        completions = {
            blink = {
                enabled = true,
            },
        },
        heading = {
            icons = {
                " ",
                " ",
                " ",
                " ",
                " ",
                " ",
            },
            position = "inline",
            backgrounds = {},
        },
        code = {
            border = "thin",
        },
        overrides = {
            filetype = {
                codecompanion = {
                    render_modes = { "n", "c", "t" },
                },
            },
        },
    },
}
