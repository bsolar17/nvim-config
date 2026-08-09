return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-mini/mini.nvim",
    },
    lazy = false,
    ft = {
        "markdown",
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
    },
}
