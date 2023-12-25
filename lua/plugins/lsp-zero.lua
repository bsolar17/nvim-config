return {
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
}
