return {
    "vscode-config",
    cond = vim.g.vscode ~= nil,
    dir = vim.fn.stdpath("config"),
    config = function()
        local vscode = require("vscode")
        vim.keymap.set(
            { "n", "v" },
            "<leader>t",
            function() vscode.action('workbench.action.terminal.toggleTerminal') end,
            { desc = "Terminal" }
        )
        vim.keymap.set(
            { "n", "v" },
            "<Leader>ca",
            function() vscode.action('editor.action.codeAction') end,
            { desc = "Actions" }
        )
        vim.keymap.set(
            "n",
            "<Leader>ch",
            function() vscode.action('editor.action.showHover') end,
            { desc = "Hover" }
        )
        vim.keymap.set(
            "n",
            "<leader>cf",
            function() vscode.action('editor.action.formatDocument') end,
            { desc = "Format" }
        )
        vim.keymap.set(
            "n",
            "<Leader>gd",
            function() vscode.action('editor.action.revealDefinition') end,
            { desc = "Definitions" }
        )
        vim.keymap.set(
            "n",
            "<Leader>gD",
            function() vscode.action('editor.action.goToDeclaration') end,
            { desc = "Declaration" }
        )
        vim.keymap.set(
            "n",
            "<Leader>gi",
            function() vscode.action('editor.action.goToImplementation') end,
            { desc = "Implementations" }
        )
        vim.keymap.set(
            "n",
            "<Leader>gt",
            function() vscode.action('editor.action.goToTypeDefinition') end,
            { desc = "Type Definitions" }
        )
        vim.keymap.set(
            "n",
            "<Leader>gr",
            function() vscode.action('editor.action.goToReferences') end,
            { desc = "References" }
        )
        vim.keymap.set(
            "n",
            "<Leader>cr",
            function() vscode.action('editor.action.rename') end,
            { desc = "Rename" }
        )
        vim.keymap.set(
            "n",
            "<leader>fb",
            function() vscode.action('workbench.action.showAllEditors') end,
            { desc = "Buffers" }
        )
        vim.keymap.set(
            "n",
            "<leader>ff",
            function() vscode.action('workbench.action.quickOpen') end,
            { desc = "Files" }
        )
        vim.keymap.set(
            "n", "<leader>fl",
            function() vscode.action('workbench.action.gotoLine') end,
            { desc = "Lines" }
        )
        vim.keymap.set(
            "n",
            "<leader>fL",
            function() vscode.action('workbench.action.gotoLine') end,
            { desc = "Lines (All Buffers)" })
        vim.keymap.set(
            "n",
            "<leader>fc",
            function() vscode.action('git.openChange') end,
            { desc = "Git Commit Files" }
        ) -- Closest: open changes
        vim.keymap.set(
            "n",
            "<leader>fm",
            function() vscode.action('git.openFile') end,
            { desc = "Git Modified" }
        ) -- Closest: open file in git
        vim.keymap.set(
            "n",
            "<leader>fo",
            function() vscode.action('workbench.action.openRecent') end,
            { desc = "Old Files" }
        )
        vim.keymap.set(
            "n",
            "<leader>fp",
            function() vscode.action('workbench.action.showCommands') end,
            { desc = "Pickers" }
        )
        vim.keymap.set(
            "n",
            "<leader>fG",
            function() vscode.action('workbench.action.findInFiles') end,
            { desc = "Grep" }
        )
        vim.keymap.set(
            "n",
            "<leader>rc",
            function() vscode.action('testing.runCurrentFile') end,
            { desc = "Class" }
        )
        vim.keymap.set(
            "n",
            "<leader>rf",
            function() vscode.action('testing.runFailed') end,
            { desc = "Rerun Failed Tests" }
        )
    end,
}
