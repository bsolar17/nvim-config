return {
    "mbbill/undotree",
    config = function()
        vim.g.undotree_SetFocusWhenToggle = true
        vim.keymap.set(
            "n",
            "<Leader>u",
            "<Cmd>UndotreeToggle<CR>",
            { desc = "Undotree" }
        )
    end,
}
