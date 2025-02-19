return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        delay = 2000,
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        wk.add(
            {
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
