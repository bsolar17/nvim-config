return {
    "saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    version = "1.*",
    opts = {
        keymap = {
            preset = "default",
            ['<Up>'] = {},
            ['<Down>'] = {},
            ['<S-Up>'] = { 'select_prev', 'fallback' },
            ['<S-Down>'] = { 'select_next', 'fallback' },
            ['<CR>'] = { 'accept', 'fallback' },
        },
        appearance = {
            nerd_font_variant = "mono",
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
                ['<Up>'] = {},
                ['<Down>'] = {},
                ['<S-Up>'] = { 'select_prev', 'fallback' },
                ['<S-Down>'] = { 'select_next', 'fallback' },
                ['<CR>'] = { 'accept_and_enter', 'fallback' },
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
