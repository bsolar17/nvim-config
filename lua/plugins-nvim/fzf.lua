return {
    "ibhagwan/fzf-lua",
    dependencies = {
        "nvim-mini/mini.nvim",
    },
    opts = {
        defaults = {
            formatter = "path.filename_first",
            hidden = true,
        },
        git = {
            diff = {
                formatter = "path.dirname_first",
            },
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
                layout = "vertical",
                wrap = true,
            },
        },
    },
    config = function(_, opts)
        local fzf = require("fzf-lua")
        fzf.setup(opts)
        fzf.register_ui_select()
        vim.keymap.set("n", "<Leader>fb", fzf.buffers, { desc = "Buffers" })
        vim.keymap.set("n", "<Leader>ff", fzf.files, { desc = "Files" })
        vim.keymap.set("n", "<Leader>fl", fzf.blines, { desc = "Lines" })
        vim.keymap.set(
            "n",
            "<Leader>fL",
            fzf.lines,
            { desc = "Lines (All Buffers)" }
        )
        vim.keymap.set("n", "<Leader>fg", fzf.git_files, { desc = "Git Files" })
        vim.keymap.set("n", "<Leader>fh", function()
            fzf.git_diff({
                ref = "origin/HEAD",
            })
        end, { desc = "Git Diff HEAD" })
        vim.keymap.set("n", "<Leader>fc", function()
            fzf.git_files({
                git_command = {
                    "git",
                    "diff-tree",
                    "--no-commit-id",
                    "--name-only",
                    "-r",
                    "HEAD",
                },
            })
        end, { desc = "Git Commit Files" })
        vim.keymap.set(
            "n",
            "<Leader>fm",
            fzf.git_status,
            { desc = "Git Modified" }
        )
        vim.keymap.set("n", "<Leader>fM", fzf.marks, { desc = "Marks" })
        vim.keymap.set("n", "<Leader>fo", fzf.oldfiles, { desc = "Old Files" })
        vim.keymap.set("n", "<Leader>fp", fzf.builtin, { desc = "Pickers" })
        vim.keymap.set("n", "<Leader>fq", fzf.quickfix, { desc = "Quickfix" })
        vim.keymap.set("n", "<Leader>fG", fzf.live_grep, { desc = "Grep" })
        vim.keymap.set("n", "<Leader>fr", fzf.registers, { desc = "Registers" })
        vim.keymap.set(
            "n",
            "<Leader>fw",
            fzf.diagnostics_document,
            { desc = "Diagnostics" }
        )
        vim.keymap.set(
            "n",
            "<Leader>fW",
            fzf.diagnostics_workspace,
            { desc = "Diagnostics Workspace" }
        )
    end,
}
