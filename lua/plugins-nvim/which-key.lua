return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        delay = 2000,
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        wk.add({
            { "<Leader>G", group = "Git" },
            { "<Leader>b", group = "Buffers" },
            { "<Leader>c", group = "Code" },
            { "<Leader>d", group = "Diff" },
            { "<Leader>f", group = "Find" },
            { "<Leader>g", group = "Go" },
            { "<Leader>h", group = "Harpoon" },
            { "<Leader>r", group = "Run" },
            { "<Leader>t", group = "Test" },
            { "<Leader>td", group = "Debug" },
            { "<Leader>x", group = "Extract" },
            { "<Leader>w", group = "Workspace" },
            { "<Leader>wt", group = "Trouble" },
        })
    end,
}
