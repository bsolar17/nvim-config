return {
    "saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    version = "1.*",
    opts = {
        keymap = {
            preset = "default",
            ['<CR>'] = { 'accept', 'fallback' },
        },
        appearance = {
            nerd_font_variant = "mono",
        },
        completion = {
            menu = {
                auto_show = true,
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 0,
            },
            list = {
                selection = {
                    preselect = false,
                    auto_insert = false,
                },
            },
        },
        sources = {
            default = {
                "lsp",
                "path",
                "snippets",
                "buffer",
            },
        },
        fuzzy = {
            implementation = "prefer_rust_with_warning",
        },
        cmdline = {
            keymap = {
                ['<CR>'] = { 'accept', 'fallback' },
            },
            completion = {
                menu = {
                    auto_show = true,
                },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = false,
                    },
                },
            },
        },
    },
    opts_extend = { "sources.default" }
}
