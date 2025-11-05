return {
    "echasnovski/mini.nvim",
    version = false,
    opts = {},
    config = function(_, opts)
        require("mini.icons").setup(opts)
    end,
}
