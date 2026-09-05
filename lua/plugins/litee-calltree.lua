-- Keymaps live with the other LSP ones in `lsp.lua` and load this plugin on
-- first use, which keeps the deprecation warning `litee.calltree.setup` trips
-- on out of sessions that never ask for a call tree.
return {
    {
        "ldelossa/litee.nvim",
        lazy = true,
        opts = {
            panel = {
                orientation = "bottom",
                panel_size = 15,
            },
        },
        config = function(_, opts)
            require("litee.lib").setup(opts)
        end,
    },
    {
        "ldelossa/litee-calltree.nvim",
        dependencies = {
            "ldelossa/litee.nvim",
        },
        lazy = true,
        opts = {
            on_open = "panel",
            map_resize_keys = false,
            -- `workspace/symbol` goes to the first attached client that
            -- supports it, `spring-boot` rather than `jdtls`; it resolves
            -- nothing and the tree waits on every one of those requests.
            resolve_symbols = false,
        },
        config = function(_, opts)
            require("litee.calltree").setup(opts)
        end,
    },
}
