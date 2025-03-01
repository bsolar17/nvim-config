return {
    {
        "nvim-telescope/telescope.nvim",
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
                path_display = {
                    "filename_first",
                },
                layout_strategy = "vertical",
                layout_config = {
                    vertical = {
                        preview_cutoff = 20,
                    },
                },
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
                git_status = {
                    path_display = {
                        truncate = 3,
                    },
                }
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
            local trouble = require("trouble.sources.telescope")
            opts.defaults.mappings = {
                i = { ["<c-o>"] = trouble.open },
                n = { ["<c-o>"] = trouble.open },
            }
            require("telescope").setup(opts)
            require("telescope").load_extension("fzf")
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Files" })
            vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Git Files" })
            vim.keymap.set("n", "<leader>fc", function()
                    builtin.git_files({
                        git_command = { "git", "diff-tree", "--no-commit-id", "--name-only", "-r", "HEAD" },
                    })
                end,
                { desc = "Git Commit Files" })
            vim.keymap.set("n", "<leader>fm", builtin.git_status, { desc = "Git Modified" })
            vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Old Files" })
            vim.keymap.set("n", "<leader>fp", builtin.builtin, { desc = "Pickers" })
            vim.keymap.set("n", "<leader>fG", builtin.live_grep, { desc = "Grep" })
            vim.keymap.set("n", "<leader>fr", builtin.registers, { desc = "Registers" })
        end
    },
}
