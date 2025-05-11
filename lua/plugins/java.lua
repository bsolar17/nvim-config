return {
    "nvim-java/nvim-java",
    lazy = true,
    opts = {
        jdtls = {
            version = "v1.46.1",
        },
        jdk = {
            auto_install = false,
        },
        notifications = {
            dap = false,
        },
        spring_boot_tools = {
            enable = false,
        },
    },
}
