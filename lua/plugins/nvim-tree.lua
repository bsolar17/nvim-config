return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        vim.keymap.set('n', '<leader>t', vim.cmd.NvimTreeToggle)
        local function my_on_attach(bufnr)
            local api = require('nvim-tree.api')

            local function opts(desc)
                return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            api.config.mappings.default_on_attach(bufnr)

            vim.keymap.del('n', 'd', opts(''))
            vim.keymap.del('n', 'D', opts(''))
            vim.keymap.del('n', 'bd', opts(''))
            vim.keymap.del('n', 'bt', opts(''))
        end

        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require('nvim-tree').setup({
            update_focused_file = {
                enable = true,
            },
            on_attach = my_on_attach
        })
    end
}
