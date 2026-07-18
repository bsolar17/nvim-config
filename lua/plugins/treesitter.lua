local function is_parser_installed(lang)
    local installed = require("nvim-treesitter").get_installed()
    return vim.tbl_contains(installed, lang)
end

local function is_parser_available(lang)
    local available = require("nvim-treesitter").get_available()
    return vim.tbl_contains(available, lang)
end

local function start_treesitter(buf, lang)
    if not vim.treesitter.language.add(lang) then
        vim.notify(
            "Cannot load treesitter parser for language " .. lang,
            vim.log.levels.WARN
        )
        return
    end
    vim.treesitter.start(buf)
    vim.bo[buf].syntax = "ON"
    if vim.treesitter.query.get(lang, "indents") then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            require("nvim-treesitter").install({ "yaml", "diff" })
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(ev)
                    local lang = vim.treesitter.language.get_lang(ev.match)
                    if not lang then
                        return
                    end
                    local buf = ev.buf
                    if is_parser_installed(lang) then
                        start_treesitter(buf, lang)
                    elseif is_parser_available(lang) then
                        require("nvim-treesitter")
                            .install(lang)
                            :await(function()
                                start_treesitter(buf, lang)
                            end)
                    end
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        init = function()
            vim.g.no_plugin_maps = true
        end,
        opts = {
            select = {
                lookahead = true,
                selection_modes = {
                    ["@parameter.outer"] = "v",
                    ["@function.outer"] = "V",
                    ["@class.outer"] = "<c-v>",
                },
            },
            move = {
                set_jumps = true,
            },
        },
        config = function(_, opts)
            require("nvim-treesitter-textobjects").setup(opts)
            vim.keymap.set({ "x", "o" }, "am", function()
                require("nvim-treesitter-textobjects.select").select_textobject(
                    "@function.outer",
                    "textobjects"
                )
            end, { desc = "@function.outer" }, {
                desc = "@function.outer",
            })
            vim.keymap.set({ "x", "o" }, "im", function()
                require("nvim-treesitter-textobjects.select").select_textobject(
                    "@function.inner",
                    "textobjects"
                )
            end, { desc = "@function.inner" })
            vim.keymap.set({ "x", "o" }, "ac", function()
                require("nvim-treesitter-textobjects.select").select_textobject(
                    "@class.outer",
                    "textobjects"
                )
            end, { desc = "@class.outer" })
            vim.keymap.set({ "x", "o" }, "ic", function()
                require("nvim-treesitter-textobjects.select").select_textobject(
                    "@class.inner",
                    "textobjects"
                )
            end, { desc = "@class.inner" })
            vim.keymap.set({ "x", "o" }, "as", function()
                require("nvim-treesitter-textobjects.select").select_textobject(
                    "@local.scope",
                    "locals"
                )
            end, { desc = "@local.scope" })
            vim.keymap.set("n", "<C-Down>", function()
                require("nvim-treesitter-textobjects.swap").swap_next(
                    "@function.outer"
                )
            end, { desc = "@function.outer" })
            vim.keymap.set("n", "<C-Up>", function()
                require("nvim-treesitter-textobjects.swap").swap_previous(
                    "@function.outer"
                )
            end, { desc = "@function.outer" })
            vim.keymap.set({ "n", "x", "o" }, "]m", function()
                require("nvim-treesitter-textobjects.move").goto_next_start(
                    "@function.outer",
                    "textobjects"
                )
            end, { desc = "@function.outer next start" })
            vim.keymap.set({ "n", "x", "o" }, "[m", function()
                require("nvim-treesitter-textobjects.move").goto_previous_start(
                    "@function.outer",
                    "textobjects"
                )
            end, { desc = "@function.outer previous start" })
            vim.keymap.set({ "n", "x", "o" }, "]M", function()
                require("nvim-treesitter-textobjects.move").goto_next_end(
                    "@function.outer",
                    "textobjects"
                )
            end, { desc = "@function.outer next end" })
            vim.keymap.set({ "n", "x", "o" }, "[M", function()
                require("nvim-treesitter-textobjects.move").goto_previous_end(
                    "@function.outer",
                    "textobjects"
                )
            end, { desc = "@function.outer previous end" })
            vim.keymap.set({ "n", "x", "o" }, "]]", function()
                require("nvim-treesitter-textobjects.move").goto_next_start(
                    "@class.outer",
                    "textobjects"
                )
            end, { desc = "@class.outer next start" })
            vim.keymap.set({ "n", "x", "o" }, "[[", function()
                require("nvim-treesitter-textobjects.move").goto_previous_start(
                    "@class.outer",
                    "textobjects"
                )
            end, { desc = "@class.outer" })
            vim.keymap.set({ "n", "x", "o" }, "]o", function()
                require("nvim-treesitter-textobjects.move").goto_next_start(
                    { "@loop.inner", "@loop.outer" },
                    "textobjects"
                )
            end, { desc = "@loop next start" })
            vim.keymap.set({ "n", "x", "o" }, "]s", function()
                require("nvim-treesitter-textobjects.move").goto_next_start(
                    "@local.scope",
                    "locals"
                )
            end, { desc = "@local.scope next start" })
            vim.keymap.set({ "n", "x", "o" }, "[s", function()
                require("nvim-treesitter-textobjects.move").goto_previous_end(
                    "@local.scope",
                    "locals"
                )
            end, { desc = "@local.scope previous end" })
            vim.keymap.set({ "n", "x", "o" }, "]z", function()
                require("nvim-treesitter-textobjects.move").goto_next_start(
                    "@fold",
                    "folds"
                )
            end, { desc = "@fold next start" })
            vim.keymap.set({ "n", "x", "o" }, "][", function()
                require("nvim-treesitter-textobjects.move").goto_next_end(
                    "@class.outer",
                    "textobjects"
                )
            end, { desc = "@class.outer next end" })
            vim.keymap.set({ "n", "x", "o" }, "[]", function()
                require("nvim-treesitter-textobjects.move").goto_previous_end(
                    "@class.outer",
                    "textobjects"
                )
            end, { desc = "@class.outer" })
            vim.keymap.set({ "n", "x", "o" }, "]d", function()
                require("nvim-treesitter-textobjects.move").goto_next(
                    "@conditional.outer",
                    "textobjects"
                )
            end, { desc = "@conditional.outer next" })
            vim.keymap.set({ "n", "x", "o" }, "[d", function()
                require("nvim-treesitter-textobjects.move").goto_previous(
                    "@conditional.outer",
                    "textobjects"
                )
            end, { desc = "@conditional.outer previous" })
        end,
    },
}
