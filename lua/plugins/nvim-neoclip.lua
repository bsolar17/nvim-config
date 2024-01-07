return {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
        {
            'kkharji/sqlite.lua',
            module = 'sqlite'
        },
        { 'nvim-telescope/telescope.nvim' },
    },
    opts = {
        enable_persistent_history = true,
        continuous_sync = true,
        default_register = "*",
    },
    config = function(_, opts)
        require("neoclip").setup(opts)
        vim.keymap.set("n", "<leader>fy", require("telescope").extensions.neoclip.default, { desc = "Yanks" })
    end
}
