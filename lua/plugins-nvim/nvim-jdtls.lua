return {
    {
        "mfussenegger/nvim-jdtls",
        lazy = true,
        dependencies = {
            "mfussenegger/nvim-dap",
        },
    },
    {
        "JavaHello/spring-boot.nvim",
        lazy = true,
        ft = {
            "java",
            "yaml",
            "jproperties",
        },
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
