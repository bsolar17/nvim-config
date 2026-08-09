local gs = require("gitsigns")
gs.setup({
    numhl = true,
    attach_to_untracked = false,
})
vim.keymap.set("n", "<Leader>Gb", function()
    gs.blame()
end, { desc = "Blame" })
vim.keymap.set("n", "<Leader>Gl", function()
    gs.blame_line({ full = true })
end, { desc = "Blame Line" })
vim.keymap.set("n", "<Leader>Gd", gs.diffthis, { desc = "Diff" })
vim.keymap.set("n", "<Leader>Gp", function()
    gs.diffthis("@^")
end, { desc = "Diff HEAD^" })
vim.keymap.set("n", "<Leader>Gs", "<Cmd>Gitsigns<CR>", { desc = "Gitsigns" })
