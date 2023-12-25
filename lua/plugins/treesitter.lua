return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
        ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query' },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enabled = true,
        },
    },
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
        if vim.fn.has('win32') == 1 then
            local install = require('nvim-treesitter.install')
            install.prefer_git = false
            install.command_extra_args = {
                curl = { '--proxy', 'http://localhost:8888' }
            }
        end
    end
}
