vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<Leader>bp", "<Cmd>bprevious<CR>", { desc = "Previous" })
vim.keymap.set("n", "<Leader>bn", "<Cmd>bnext<CR>", { desc = "Next" })
vim.keymap.set("n", "<Leader>bd", "<Cmd>bdelete<CR>", { desc = "Delete" })
