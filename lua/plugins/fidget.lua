return {
    "j-hui/fidget.nvim",
    opts = {
        notification = {
            override_vim_notify = true,
            window = {
                winblend = 0,
            },
        },
        progress = {
            ignore = {
                function(msg)
                    return msg.lsp_client.name == "jdtls"
                            and string.find(msg.title, "Publish Diagnostics")
                        or string.find(msg.title, "Validate documents")
                end,
            },
        },
    },
}
