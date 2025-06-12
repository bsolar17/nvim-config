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

local opts = {
    checker = {
        enabled = false,
        notify = true,
        frequency = 86400,
        check_pinned = true,
    }
}

if vim.g.vscode then
    require("lazy").setup(
        {
            { import = "plugins-all" },
            { import = "plugins-vscode" },
        },
        opts)
else
    require("lazy").setup(
        {
            { import = "plugins-all" },
            { import = "plugins-nvim" },
        },
        opts)
end
