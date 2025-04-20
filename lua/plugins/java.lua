return {
    "nvim-java/nvim-java",
    lazy = true,
    opts = {
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
