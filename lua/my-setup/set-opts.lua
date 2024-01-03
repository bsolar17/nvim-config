local home = os.getenv('HOME')

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.laststatus = 0
vim.opt.title = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.scrolloff = 8

vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.showbreak = ''
vim.opt.breakindentopt = 'sbr'
vim.opt.cpoptions:append('n')

vim.opt.undodir = home .. '/.nvim/undo'
vim.opt.directory = home .. '/.nvim/swap'
vim.opt.backupdir = home .. '/.nvim/backup'
vim.opt.undofile = true
vim.opt.backupcopy = 'yes'

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.clipboard = 'unnamedplus'
