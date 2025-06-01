return {
    "lukas-reineke/indent-blankline.nvim",
    cond = not vim.g.vscode,
    main = "ibl",
    opts = {
        indent = {
            char = "▏"
        },
        scope = {
            char = "▎",
            highlight = "Whitespace",
        },
    }
}
