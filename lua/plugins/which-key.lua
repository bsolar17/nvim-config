return {
    'folke/which-key.nvim',
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
    end,
    config = function()
        local wk = require("which-key")
        wk.register({
            ["<leader>"] = {
                c = {
                    name = "code",
                },
                d = {
                    name = "debug",
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
