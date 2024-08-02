return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
    end,
    config = function()
        local wk = require("which-key")
        wk.add(
            {
                { "<leader>C", group = "copilot" },
                { "<leader>G", group = "git" },
                { "<leader>b", group = "buffers" },
                { "<leader>c", group = "code" },
                { "<leader>d", group = "debug" },
                { "<leader>f", group = "find" },
                { "<leader>g", group = "go" },
                { "<leader>h", group = "harpoon" },
                { "<leader>j", group = "java" },
                { "<leader>t", group = "trouble" },
            }
        )
    end
}
