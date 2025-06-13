vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set(
    "n",
    "<Leader>bp",
    "<cmd>bprevious<cr>",
    { desc = "Previous" }
)
vim.keymap.set(
    "n",
    "<Leader>bn",
    "<cmd>bnext<cr>",
    { desc = "Next" }
)
vim.keymap.set(
    "n",
    "<Leader>bd",
    "<cmd>bdelete<cr>",
    { desc = "Delete" }
)
