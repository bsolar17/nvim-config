vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<Leader>bp", "<Cmd>bprevious<CR>", { desc = "Previous" })
vim.keymap.set("n", "<Leader>bn", "<Cmd>bnext<CR>", { desc = "Next" })
vim.keymap.set("n", "<Leader>bd", "<Cmd>bdelete<CR>", { desc = "Delete" })
vim.keymap.set("n", "<Leader>bt", function()
    if vim.fn.tabpagenr("$") == 1 then
        vim.cmd("tab split")
    else
        vim.cmd("tabclose")
    end
end, { desc = "Tab Split/Close Toggle" })
vim.keymap.set({ "n", "x", "o" }, "<A-o>", function()
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
        require("vim.treesitter._select").select_parent(vim.v.count1)
    else
        vim.lsp.buf.selection_range(vim.v.count1)
    end
end, { desc = "Select Out" })
vim.keymap.set({ "n", "x", "o" }, "<A-i>", function()
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
        require("vim.treesitter._select").select_child(vim.v.count1)
    else
        vim.lsp.buf.selection_range(-vim.v.count1)
    end
end, { desc = "Select In" })
