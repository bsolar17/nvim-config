return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                name = "fzf",
                build = "make",
            }
        },
        opts = {
            defaults = {
                path_display = { "smart" },
                dynamic_preview_title = true,
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("fzf")
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Files" })
            vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Git Files" })
            vim.keymap.set("n", "<leader>fm", builtin.git_status, { desc = "Git Modified" })
            vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Old Files" })
            vim.keymap.set("n", "<leader>fp", builtin.builtin, { desc = "Pickers" })
            vim.keymap.set("n", "<leader>fr", builtin.live_grep, { desc = "Grep" })
        end
    },
}
