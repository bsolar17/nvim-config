return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
    end,
    config = function()
        local wk = require("which-key")
        wk.register({
            ["<leader>"] = {
                b = {
                    name = "buffers",
                },
                c = {
                    name = "code",
                },
                d = {
                    name = "debug",
                },
                f = {
                    name = "find",
                },
                g = {
                    name = "go",
                },
                h = {
                    name = "harpoon",
                },
                j = {
                    name = "java",
                },
                t = {
                    name = "trouble",
                },
                G = {
                    name = "git",
                },
            }
        })
    end
}
