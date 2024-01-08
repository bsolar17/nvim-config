return {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            changedelete = { text = "-" },
        },
        numhl = true,
        attach_to_untracked = false,
    },
    config = function(_, opts)
        require("gitsigns").setup(opts)
        vim.keymap.set("n", "<Leader>b", "<cmd>lua require('gitsigns').blame_line({ full = true})<CR>",
            { desc = "Git Blame" })
    end
}
