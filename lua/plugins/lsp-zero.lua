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
        lsp_zero.on_attach(function()
            vim.keymap.set('n', '<Leader>ch', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = 'Hover' })
            vim.keymap.set('n', '<Leader>cd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = 'Definition' })
            vim.keymap.set('n', '<Leader>c=', '<cmd>lua vim.lsp.buf.declaration()<cr>', { desc = 'Declaration' })
            vim.keymap.set('n', '<Leader>ci', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = 'Implementation' })
            vim.keymap.set('n', '<Leader>ct', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { desc = 'Type Definition' })
            vim.keymap.set('n', '<Leader>cr', '<cmd>lua vim.lsp.buf.references()<cr>', { desc = 'References' })
            vim.keymap.set('n', '<Leader>cs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { desc = 'Signature Help' })
            vim.keymap.set('n', '<Leader>cn', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'Rename' })
            vim.keymap.set({ 'n', 'x' }, '<Leader>cf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
                { desc = 'Format' })
            -- vim.keymap.set('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'Code Action' })
            vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', { desc = 'Open Float' })
            vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', { desc = 'Goto Prev' })
            vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', { desc = 'Goto Next' })
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
