return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/vim-vsnip",
        },
        config = function()
            local cmp = require "cmp"
            cmp.setup({
                -- Enable LSP snippets
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                -- Installed sources:
                sources = {
                    { name = "path" },                                       -- file paths
                    { name = "nvim_lsp",               keyword_length = 3 }, -- from language server
                    { name = "nvim_lsp_signature_help" },                    -- display function signatures with current parameter emphasized
                    { name = "nvim_lua",               keyword_length = 2 }, -- complete neovim"s Lua runtime API such vim.lsp.*
                    { name = "buffer",                 keyword_length = 2 }, -- source current buffer
                    { name = "vsnip",                  keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
                    { name = "calc" },                                       -- source for math calculation
                },
                mapping = {
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            local entry = cmp.get_selected_entry()
                            if not entry then
                                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                            end
                            cmp.confirm()
                        else
                            fallback()
                        end
                    end, { "i", "s", "c", }),
                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            local entry = cmp.get_selected_entry()
                            if not entry then
                                fallback()
                            else
                                cmp.confirm()
                            end
                        else
                            fallback()
                        end
                    end, { "i", "s", "c", }),
                    ["<S-Up>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback()
                        end
                    end, { "i", "s", "c", }),
                    ["<S-Down>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback()
                        end
                    end, { "i", "s", "c", }),
                    ['<C-e>'] = cmp.mapping.abort(),
                },
                preselect = cmp.PreselectMode.None,
                completion = {
                    completeopt = "menu,menuone,noinsert,preview,noselect",
                },
                formatting = {
                    fields = { "menu", "abbr", "kind" },
                    format = function(entry, item)
                        local menu_icon = {
                            nvim_lsp = "λ",
                            vsnip = "⋗",
                            buffer = "Ω",
                            path = "",
                        }
                        item.menu = menu_icon[entry.source.name]
                        return item
                    end,
                },
                experimental = {
                    ghost_text = true
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
            })
            cmp.setup.cmdline({"/", "?"}, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" }
                }
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" }
                }, {
                    { name = "cmdline" }
                })
            })
        end
    },
}
