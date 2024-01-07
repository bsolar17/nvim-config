return {
    "mfussenegger/nvim-jdtls",
    config = function()
        vim.keymap.set(
            "n",
            "<leader>jo",
            "<Cmd>lua require'jdtls'.organize_imports()<CR>",
            { buffer = buffer, desc = "Organize Imports" }
        )
        vim.keymap.set(
            "n",
            "<leader>jt",
            "<Cmd>lua require'jdtls'.test_class()<CR>",
            { buffer = buffer, desc = "Test Class" }
        )
        vim.keymap.set(
            "n",
            "<leader>jn",
            "<Cmd>lua require'jdtls'.test_nearest_method()<CR>",
            { buffer = buffer, desc = "Test Nearest Method" }
        )
        vim.keymap.set(
            "v",
            "<leader>jv",
            "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
            { buffer = buffer, desc = "Extract Variable" }
        )
        vim.keymap.set(
            "n",
            "<leader>jv",
            "<Cmd>lua require('jdtls').extract_variable()<CR>",
            { buffer = buffer, desc = "Extract Variable" }
        )
        vim.keymap.set(
            "v",
            "<leader>jc",
            "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
            { buffer = buffer, desc = "Extract Constant" }
        )
        vim.keymap.set(
            "n",
            "<leader>jc",
            "<Cmd>lua require('jdtls').extract_constant()<CR>",
            { buffer = buffer, desc = "Extract Variable" }
        )
        vim.keymap.set(
            "v",
            "<leader>jm",
            "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
            { buffer = buffer, desc = "Extract Method" }
        )
        vim.keymap.set(
            "n",
            "<leader>jf",
            "<cmd>lua vim.lsp.buf.formatting()<CR>",
            { buffer = buffer, desc = "Format" }
        )
    end
}
