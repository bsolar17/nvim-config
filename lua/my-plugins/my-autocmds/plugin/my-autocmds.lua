vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    callback = function()
        vim.g.editorconfig = false
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt.textwidth = 80
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "xml",
    callback = function()
        vim.api.nvim_command("filetype indent off")
    end,
})
