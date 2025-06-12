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
                { "<leader>G",  group = "Git" },
                { "<leader>b",  group = "Buffers" },
                { "<leader>c",  group = "Code" },
                { "<leader>d",  group = "Debug" },
                { "<leader>f",  group = "Find" },
                { "<leader>g",  group = "Go" },
                { "<leader>h",  group = "Harpoon" },
                { "<leader>r",  group = "Run" },
                { "<leader>t",  group = "Test" },
                { "<leader>td", group = "Debug" },
                { "<leader>x",  group = "Extract" },
                { "<leader>w",  group = "Workspace" },
                { "<leader>wt", group = "Trouble" },
            }
        )
    end
}
