local harpoon = require('harpoon')

harpoon:setup()

vim.keymap.set("n", "<Leader>ha", function() harpoon:list():append() end)
vim.keymap.set("n", "<Leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<Leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<Leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<Leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<Leader>4", function() harpoon:list():select(4) end)
