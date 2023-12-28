return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup()
        vim.keymap.set("n", "<Leader>ha", function() harpoon:list():append() end, { desc = "Harpoon Append" })
        vim.keymap.set("n", "<Leader>hc", function() harpoon:list():clear() end, { desc = "Harpoon Clear" })
        vim.keymap.set("n", "<Leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Harpoon Menu" })
        vim.keymap.set("n", "<Leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon 1" })
        vim.keymap.set("n", "<Leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon 2" })
        vim.keymap.set("n", "<Leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon 3" })
        vim.keymap.set("n", "<Leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon 4" })
    end
}
