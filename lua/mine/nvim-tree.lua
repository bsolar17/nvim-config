local function my_on_attach(bufnr)
    local api = require 'nvim-tree.api'

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.del('n', 'd', opts(''))
    vim.keymap.del('n', 'D', opts(''))
    vim.keymap.del('n', 'bd', opts(''))
    vim.keymap.del('n', 'bt', opts(''))
end

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require('nvim-tree').setup({
    on_attach = my_on_attach
})

