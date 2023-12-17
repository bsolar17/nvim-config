local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        'catppuccin/nvim',
        lazy = false,
        priority = 1000,
        name = 'catppuccin',
        config = function()
            require('catppuccin').setup({ transparent_background = true })
            vim.cmd('colorscheme catppuccin-mocha')
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require 'nvim-treesitter.configs'.setup {
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
            }
            if vim.fn.has('win32') == 1 then
                local install = require('nvim-treesitter.install')
                install.prefer_git = false
                install.command_extra_args = {
                    curl = { '--proxy', 'http://localhost:8888' }
                }
            end
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup {
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
            }
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
            vim.keymap.set('n', '<leader>fr', builtin.live_grep, {})
        end
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
        end
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            vim.keymap.set('n', '<leader>e', vim.cmd.NvimTreeToggle)
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
                update_focused_file = {
                    enable = true,
                },
                on_attach = my_on_attach
            })
        end
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        },
        config = function()
            local lsp_zero = require('lsp-zero')
            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
                vim.keymap.set('n', '<Leader>ch', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                vim.keymap.set('n', '<Leader>cd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                vim.keymap.set('n', '<Leader>c=', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                vim.keymap.set('n', '<Leader>ci', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                vim.keymap.set('n', '<Leader>ct', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                vim.keymap.set('n', '<Leader>cr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                vim.keymap.set('n', '<Leader>cs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                vim.keymap.set('n', '<Leader>cn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                vim.keymap.set({ 'n', 'x' }, '<Leader>cf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                vim.keymap.set('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
                vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
                vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
            end)
            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    lsp_zero.default_setup,
                },
            })
        end
    },
    {
        'tpope/vim-commentary',
    },
    {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require 'cmp'
            cmp.setup({
                -- Enable LSP snippets
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                -- Installed sources:
                sources = {
                    { name = 'path' },                                       -- file paths
                    { name = 'nvim_lsp',               keyword_length = 3 }, -- from language server
                    { name = 'nvim_lsp_signature_help' },                    -- display function signatures with current parameter emphasized
                    { name = 'nvim_lua',               keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
                    { name = 'buffer',                 keyword_length = 2 }, -- source current buffer
                    { name = 'vsnip',                  keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
                    { name = 'calc' },                                       -- source for math calculation
                },
                mapping = {
                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            local entry = cmp.get_selected_entry()
                            if not entry then
                                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                            else
                                cmp.confirm()
                            end
                        else
                            fallback()
                        end
                    end, { "i", "s", "c", }),
                    ["<Up>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback()
                        end
                    end, { "i", "s", "c", }),
                    ["<Down>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback()
                        end
                    end, { "i", "s", "c", }),
                },
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },
                formatting = {
                    fields = { 'menu', 'abbr', 'kind' },
                    format = function(entry, item)
                        local menu_icon = {
                            nvim_lsp = 'λ',
                            vsnip = '⋗',
                            buffer = 'Ω',
                            path = '',
                        }
                        item.menu = menu_icon[entry.source.name]
                        return item
                    end,
                },
                experimental = {
                    ghost_text = true
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
            })
        end
    },
    {
        'hrsh7th/cmp-nvim-lsp',
    },
    {
        'hrsh7th/cmp-nvim-lua',
    },
    {
        'hrsh7th/cmp-nvim-lsp-signature-help',
    },
    {
        'hrsh7th/cmp-vsnip',
    },
    {
        'hrsh7th/cmp-path',
    },
    {
        'hrsh7th/cmp-buffer',
    },
    {
        'hrsh7th/vim-vsnip',
    },
    {
        'aznhe21/actions-preview.nvim',
        config = function()
            vim.keymap.set({ "v", "n" }, "<leader>a", require("actions-preview").code_actions)
        end
    },
    {
        'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup {} end
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local harpoon = require('harpoon')
            harpoon:setup()
            vim.keymap.set("n", "<Leader>ha", function() harpoon:list():append() end)
            vim.keymap.set("n", "<Leader>hd", function() harpoon:list():remove() end)
            vim.keymap.set("n", "<Leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
            vim.keymap.set("n", "<Leader>1", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<Leader>2", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<Leader>3", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<Leader>4", function() harpoon:list():select(4) end)
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require("gitsigns").setup {
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    changedelete = { text = '-' },
                },
                numhl = true,
                attach_to_untracked = false,
            }
        end
    },
})
