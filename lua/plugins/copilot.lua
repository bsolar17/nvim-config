return {
    "github/copilot.vim",
    event = "InsertEnter",
    init = function()
        vim.keymap.set('i', '<C-Space>', '<Plug>(copilot-suggest)')
        vim.keymap.set('i', '<C-e>', '<Plug>(copilot-dismiss)')
        vim.keymap.set('i', '<Tab>', 'copilot#Accept("\\<Tab>")', {
            expr = true,
            replace_keycodes = false
        })
        vim.g.copilot_no_tab_map = true
        vim.g.copilot_assume_mapped = true
        vim.g.copilot_enabled = false
    end,
}
