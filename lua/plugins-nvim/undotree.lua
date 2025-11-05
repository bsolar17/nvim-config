return {
    "mbbill/undotree",
    config = function()
        vim.g.undotree_SetFocusWhenToggle = true
        vim.keymap.set(
            "n",
            "<leader>u",
            "<cmd>UndotreeToggle<cr>",
            { desc = "Undotree" }
        )
    end,
}
