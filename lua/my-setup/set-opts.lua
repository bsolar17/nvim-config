vim.opt.shortmess:append("I")
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.laststatus = 3
vim.opt.title = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 8
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.backupcopy = "yes"
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.winborder = "rounded"
vim.opt.signcolumn = "yes"
vim.opt.timeout = false
vim.opt.splitright = true
vim.filetype.add(
    {
        extension = {
            avsc = "json",
        },
    }
)
