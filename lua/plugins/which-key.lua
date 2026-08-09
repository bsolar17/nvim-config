local wk = require("which-key")
wk.setup({
    delay = 2000,
})
wk.add({
    { "<Leader>G", group = "Git" },
    { "<Leader>b", group = "Buffers" },
    { "<Leader>c", group = "Code" },
    { "<Leader>cl", group = "CodeLens" },
    { "<Leader>d", group = "Diff" },
    { "<Leader>f", group = "Find" },
    { "<Leader>g", group = "Go" },
    { "<Leader>h", group = "Harpoon" },
    { "<Leader>r", group = "Reference" },
    { "<Leader>ra", group = "Absolute" },
    { "<Leader>t", group = "Test" },
    { "<Leader>td", group = "Debug" },
    { "<Leader>x", group = "Extract" },
    { "<Leader>w", group = "Workspace" },
    { "<Leader>wt", group = "Trouble" },
})
