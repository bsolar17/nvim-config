return {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    opts = {
        flavour = "mocha",
        transparent_background = true,
        custom_highlights = {
            -- litee draws its panels with `winhighlight=Normal:NormalSB`,
            -- which keeps an opaque background under a transparent theme.
            NormalSB = { bg = "NONE" },
        },
    },
    config = function(_, opts)
        require("catppuccin").setup(opts)
        vim.cmd("colorscheme catppuccin-nvim")
    end,
}
