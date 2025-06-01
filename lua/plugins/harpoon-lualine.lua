return {
    "letieu/harpoon-lualine",
    cond = not vim.g.vscode,
    dependencies = {
        {
            "ThePrimeagen/harpoon",
            branch = "harpoon2",
        }
    },
}
