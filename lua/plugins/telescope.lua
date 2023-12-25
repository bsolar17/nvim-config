return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            defaults = {
                path_display = { 'smart' }
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            },
        },
        config = function(_, opts)
            require('telescope').setup(opts)
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
            vim.keymap.set('n', '<leader>fr', builtin.live_grep, {})
        end
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    }
}
