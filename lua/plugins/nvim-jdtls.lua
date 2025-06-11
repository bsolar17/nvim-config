return {
    {
        "mfussenegger/nvim-jdtls",
        cond = not vim.g.vscode,
        lazy = true,
    },
    {
        "my-java-autocmd",
        cond = not vim.g.vscode,
        dir = vim.fn.stdpath("config") .. "/lua/plugins/my-java-autocmd",
    },
}
