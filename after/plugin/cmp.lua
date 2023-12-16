local cmp = require'cmp'
cmp.setup({
    -- Enable LSP snippets
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    -- Installed sources:
    sources = {
        { name = 'path' },                              -- file paths
        { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
        { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
        { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
        { name = 'buffer', keyword_length = 2 },        -- source current buffer
        { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
        { name = 'calc'},                               -- source for math calculation
    },
    mapping = {
        ['<Tab>'] = cmp.mapping.confirm({select = false}),
    },
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    --window = {
        --    completion = cmp.config.window.bordered(),
        --    documentation = cmp.config.window.bordered(),
        --},
        formatting = {
            fields = {'menu', 'abbr', 'kind'},
            format = function(entry, item)
                local menu_icon ={
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
        }
    })

