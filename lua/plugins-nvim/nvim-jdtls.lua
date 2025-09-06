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
}
