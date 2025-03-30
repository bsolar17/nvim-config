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
            documentation = {
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
    },
    opts_extend = { "sources.default" }
}
