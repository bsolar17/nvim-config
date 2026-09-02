return {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
        "dlyongemallo/diffview-plus.nvim",
        "ibhagwan/fzf-lua",
    },
    cmd = "Neogit",
    keys = {
        { "<leader>dg", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
}
