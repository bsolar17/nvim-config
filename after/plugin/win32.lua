if vim.fn.has('win32') == 1 then
    local install = require('nvim-treesitter.install')
    install.prefer_git = false
    install.command_extra_args = {
        curl = { '--proxy', 'http://localhost:8888' }
    }
end
