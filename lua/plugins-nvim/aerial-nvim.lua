return {
    "stevearc/aerial.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    keys = {
        {
            mode = "n",
            "<Leader>a",
            "<cmd>AerialToggle!<CR>",
            desc = "Aerial",
        },
    },
    opts = {},
}
