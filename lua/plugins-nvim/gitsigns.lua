return {
    "lewis6991/gitsigns.nvim",
    opts = {
        numhl = true,
        attach_to_untracked = false,
    },
    config = function(_, opts)
        local gs = require("gitsigns")
        gs.setup(opts)
        vim.keymap.set(
            "n",
            "<Leader>Gb",
            function() gs.blame_line { full = true } end,
            { desc = "Blame" }
        )
        vim.keymap.set(
            "n",
            "<Leader>Gd",
            gs.diffthis,
            { desc = "Diff" }
        )
        vim.keymap.set(
            "n",
            "<Leader>Gp",
            function() gs.diffthis("@^") end,
            { desc = "Diff HEAD^" }
        )
        vim.keymap.set(
            "n",
            "<Leader>Gs",
            "<cmd>Gitsigns<cr>",
            { desc = "Gitsigns" }
        )
    end
}
