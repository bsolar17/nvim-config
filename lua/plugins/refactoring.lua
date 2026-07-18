return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    opts = {},
    config = function(_, opts)
        local refactoring = require("refactoring")
        refactoring.setup(opts)
        vim.keymap.set({ "n", "x" }, "<Leader>xm", function()
            return require("refactoring").refactor("Extract Function")
        end, { expr = true, desc = "Method" })
        vim.keymap.set({ "n", "x" }, "<Leader>xM", function()
            return require("refactoring").refactor("Extract Function To File")
        end, { expr = true, desc = "Method to File" })
        vim.keymap.set({ "n", "x" }, "<Leader>xv", function()
            return require("refactoring").refactor("Extract Variable")
        end, { expr = true, desc = "Variable" })
        vim.keymap.set({ "n", "x" }, "<Leader>cI", function()
            return require("refactoring").refactor("Inline Function")
        end, { expr = true, desc = "Inline Method" })
        vim.keymap.set({ "n", "x" }, "<Leader>ci", function()
            return require("refactoring").refactor("Inline Variable")
        end, { expr = true, desc = "Inline Variable" })
        vim.keymap.set({ "n", "x" }, "<Leader>xb", function()
            return require("refactoring").refactor("Extract Block")
        end, { expr = true, desc = "Block" })
        vim.keymap.set({ "n", "x" }, "<Leader>xB", function()
            return require("refactoring").refactor("Extract Block To File")
        end, { expr = true, desc = "Block to File" })
    end,
}
