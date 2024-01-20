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
            },
            { "folke/trouble.nvim" }
        },
        opts = {
            defaults = {
                path_display = { "smart" },
                dynamic_preview_title = true,
            },
            pickers = {
                lsp_definitions = {
                    include_current_line = true,
                    show_line = false,
                },
                lsp_implementations = {
                    include_current_line = true,
                    show_line = false,
                },
                lsp_type_definitions = {
                    include_current_line = true,
                    show_line = false,
                },
                lsp_references = {
                    include_current_line = true,
                    show_line = false,
                },
                lsp_incoming_calls = {
                    include_current_line = true,
                    show_line = false,
                },
                lsp_outgoing_calls = {
                    include_current_line = true,
                    show_line = false,
                },
                lsp_document_symbols = {
                    symbol_width = 50,
                    show_line = false,
                },
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
            local trouble = require("trouble.providers.telescope")
            opts.defaults.mappings = {
                i = { ["<c-o>"] = trouble.open_with_trouble },
                n = { ["<c-o>"] = trouble.open_with_trouble },
            }
            require("telescope").setup(opts)
            require("telescope").load_extension("fzf")
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Files" })
            vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Git Files" })
            vim.keymap.set("n", "<leader>fm", builtin.git_status, { desc = "Git Modified" })
            vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Old Files" })
            vim.keymap.set("n", "<leader>fp", builtin.builtin, { desc = "Pickers" })
            vim.keymap.set("n", "<leader>fG", builtin.live_grep, { desc = "Grep" })
        end
    },
}
