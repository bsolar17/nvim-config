return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()
        vim.keymap.set("n", "<Leader>ha", function() harpoon:list():add() end, { desc = "Add" })
        vim.keymap.set("n", "<Leader>hc", function() harpoon:list():clear() end, { desc = "Clear" })
        vim.keymap.set("n", "<Leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Menu" })
        for i = 1, 9 do
            vim.keymap.set("n", "<Leader>" .. tostring(i), function() harpoon:list():select(i) end,
                { desc = tostring(i) })
        end
    end
}
