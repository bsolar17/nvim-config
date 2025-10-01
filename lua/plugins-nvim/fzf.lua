return {
    "ibhagwan/fzf-lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "rcarriga/nvim-notify",
    },
    opts = {
        "hide",
        defaults = {
            formatter = "path.filename_first",
        },
        oldfiles = {
            cwd_only = true,
            include_current_session = true,
            file_ignore_patterns = { "COMMIT_EDITMSG" },
        },
        lsp = {
            includeDeclaration = false,
        },
        fzf_opts = {
            ["--cycle"] = true,
        },
        winopts = {
            preview = {
                wrap = true,
            },
        },
    },
    config = function(_, opts)
        local fzf = require("fzf-lua")
        fzf.setup(opts)
        fzf.register_ui_select()
        vim.keymap.set(
            "n",
            "<leader>fb",
            fzf.buffers,
            { desc = "Buffers" }
        )
        vim.keymap.set(
            "n",
            "<leader>ff",
            fzf.files,
            { desc = "Files" }
        )
        vim.keymap.set(
            "n",
            "<leader>fl",
            fzf.blines,
            { desc = "Lines" }
        )
        vim.keymap.set(
            "n",
            "<leader>fL",
            fzf.lines,
            { desc = "Lines (All Buffers)" }
        )
        vim.keymap.set(
            "n",
            "<leader>fg",
            fzf.git_files,
            { desc = "Git Files" }
        )
        vim.keymap.set(
            "n",
            "<leader>fc",
            function()
                fzf.git_files(
                    {
                        git_command = {
                            "git",
                            "diff-tree",
                            "--no-commit-id",
                            "--name-only",
                            "-r",
                            "HEAD",
                        },
                    }
                )
            end,
            { desc = "Git Commit Files" }
        )
        vim.keymap.set(
            "n",
            "<leader>fm",
            fzf.git_status,
            { desc = "Git Modified" }
        )
        vim.keymap.set(
            "n",
            "<leader>fM",
            fzf.marks,
            { desc = "Marks" }
        )
        vim.keymap.set(
            "n",
            "<leader>fo",
            fzf.oldfiles,
            { desc = "Old Files" }
        )
        vim.keymap.set(
            "n",
            "<leader>fp",
            fzf.builtin,
            { desc = "Pickers" }
        )
        vim.keymap.set(
            "n",
            "<leader>fq",
            fzf.quickfix,
            { desc = "Quickfix" }
        )
        vim.keymap.set(
            "n",
            "<leader>fG",
            fzf.live_grep,
            { desc = "Grep" }
        )
        vim.keymap.set(
            "n",
            "<leader>fr",
            fzf.registers,
            { desc = "Registers" }
        )
        vim.keymap.set(
            "n",
            "<leader>fn",
            function()
                require("notify.integrations").pick()
            end,
            { desc = "Notifications" }
        )
    end
}
