require("blink.cmp").setup({
    keymap = {
        preset = "default",
        ["<Up>"] = {},
        ["<Down>"] = {},
        ["<S-Up>"] = { "select_prev", "fallback" },
        ["<S-Down>"] = { "select_next", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
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
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
        },
    },
    sources = {
        default = {
            "lsp",
            "path",
            "snippets",
            "buffer",
            "omni",
        },
        providers = {
            lsp = {
                fallbacks = {},
            },
        },
    },
    snippets = {
        preset = "luasnip",
    },
    fuzzy = {
        implementation = "prefer_rust_with_warning",
    },
    cmdline = {
        keymap = {
            preset = "inherit",
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
})
