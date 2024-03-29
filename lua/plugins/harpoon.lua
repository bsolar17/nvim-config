return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()
        vim.keymap.set("n", "<Leader>ha", function() harpoon:list():append() end, { desc = "Append" })
        vim.keymap.set("n", "<Leader>hp", function() harpoon:list():prepend() end, { desc = "Prepend" })
        vim.keymap.set("n", "<Leader>hc", function() harpoon:list():clear() end, { desc = "Clear" })
        vim.keymap.set("n", "<Leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Menu" })
        for i = 1, 4 do
            vim.keymap.set("n", "<Leader>h" .. i, function() harpoon:list():select(i) end, { desc = tostring(i) })
        end
    end
}
