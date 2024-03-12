return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-calc",
            "dcampos/cmp-snippy",
            "dcampos/nvim-snippy",
            "honza/vim-snippets",
            "zbirenbaum/copilot-cmp",
            "windwp/nvim-autopairs",
        },
        config = function()
            local cmp = require "cmp"
            local kind_icons = {
                Text = "",
                Method = "",
                Function = "",
                Constructor = "",
                Field = "",
                Variable = "",
                Class = "",
                Interface = "",
                Module = "",
                Property = "",
                Unit = "",
                Value = "",
                Enum = "",
                Keyword = "",
                Snippet = "",
                Color = "",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "",
                Struct = "",
                Event = "",
                Operator = "",
                TypeParameter = "",
                Copilot = "",
            }
            local menu_icons = {
                nvim_lsp = "λ",
                nvim_lsp_signature_help = "λ",
                snippy = "",
                buffer = "Ω",
                path = "",
                calc = "",
                copilot = "",
                nvim_lua = "",
                cmdline = ":",
            }
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('snippy').expand_snippet(args.body)
                    end,
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "path" },
                    { name = "buffer" },
                    { name = "snippy" },
                    { name = "calc" },
                    { name = "copilot" },
                    { name = "nvim_lua" },
                },
                mapping = {
                    ["<C-Space>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            local entry = cmp.get_selected_entry()
                            if not entry then
                                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                            end
                            cmp.confirm()
                        else
                            cmp.complete()
                        end
                    end, { "i", "s", "c", }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
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
                        item.menu = menu_icons[entry.source.name] or entry.source.name
                        item.menu_hl_group = "CmpItemKind" .. item.kind
                        item.kind = (entry.source.name == "calc" and item.menu or kind_icons[item.kind] or "?") .. " " .. item.kind
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
            cmp.setup.cmdline({ "/", "?" }, {
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
            cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
        end
    },
}
