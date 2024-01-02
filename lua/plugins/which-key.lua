return {
    'folke/which-key.nvim',
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        local wk = require("which-key")
        wk.register({
            ["<leader>"] = {
                c = {
                    name = "code",
                },
                f = {
                    name = "find",
                },
                h = {
                    name = "harpoon",
                },
                j = {
                    name = "java",
                },
            }
        })
    end
}
