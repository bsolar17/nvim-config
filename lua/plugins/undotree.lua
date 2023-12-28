return {
    'mbbill/undotree',
    config = function()
        vim.g.undotree_SetFocusWhenToggle = true
        vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Undotree" })
    end
}
