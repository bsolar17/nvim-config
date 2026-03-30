return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
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
            end, { desc = "@function.outer" })
            vim.keymap.set({ "n", "x", "o" }, "]]", function()
                require("nvim-treesitter-textobjects.move").goto_next_start(
                    "@class.outer",
                    "textobjects"
                )
            end, { desc = "@class.outer" })
            vim.keymap.set({ "n", "x", "o" }, "]o", function()
                require("nvim-treesitter-textobjects.move").goto_next_start(
                    { "@loop.inner", "@loop.outer" },
                    "textobjects"
                )
            end, { desc = "@loop" })
            vim.keymap.set({ "n", "x", "o" }, "]s", function()
                require("nvim-treesitter-textobjects.move").goto_next_start(
                    "@local.scope",
                    "locals"
                )
            end, { desc = "@local.scope" })
            vim.keymap.set({ "n", "x", "o" }, "]z", function()
                require("nvim-treesitter-textobjects.move").goto_next_start(
                    "@fold",
                    "folds"
                )
            end, { desc = "@fold" })

            vim.keymap.set({ "n", "x", "o" }, "]M", function()
                require("nvim-treesitter-textobjects.move").goto_next_end(
                    "@function.outer",
                    "textobjects"
                )
            end, { desc = "@function.outer" })
            vim.keymap.set({ "n", "x", "o" }, "][", function()
                require("nvim-treesitter-textobjects.move").goto_next_end(
                    "@class.outer",
                    "textobjects"
                )
            end, { desc = "@class.outer" })
            vim.keymap.set({ "n", "x", "o" }, "[m", function()
                require("nvim-treesitter-textobjects.move").goto_previous_start(
                    "@function.outer",
                    "textobjects"
                )
            end, { desc = "@function.outer" })
            vim.keymap.set({ "n", "x", "o" }, "[[", function()
                require("nvim-treesitter-textobjects.move").goto_previous_start(
                    "@class.outer",
                    "textobjects"
                )
            end, { desc = "@class.outer" })
            vim.keymap.set({ "n", "x", "o" }, "[M", function()
                require("nvim-treesitter-textobjects.move").goto_previous_end(
                    "@function.outer",
                    "textobjects"
                )
            end, { desc = "@function.outer" })
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
            end, { desc = "@conditional.outer" })
            vim.keymap.set({ "n", "x", "o" }, "[d", function()
                require("nvim-treesitter-textobjects.move").goto_previous(
                    "@conditional.outer",
                    "textobjects"
                )
            end, { desc = "@conditional.outer" })
        end,
    },
}
