return {
    {
        "mfussenegger/nvim-jdtls",
        lazy = true,
    },
    {
        "JavaHello/spring-boot.nvim",
        lazy = true,
        dependencies = {
            "mfussenegger/nvim-jdtls",
        },
        opts = {},
    },
    {
        "my-java-autocmd",
        dir = vim.fn.stdpath("config") .. "/lua/my-plugins/my-java-autocmd",
    },
}
