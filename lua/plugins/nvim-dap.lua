return {
    {
        'mfussenegger/nvim-dap',
        config = function()
            vim.keymap.set("n", "<Leader>du", "<cmd>lua require('dapui').toggle()<CR>", { desc = "DAP-UI" })
            vim.keymap.set("n", "<Leader>d5", "<cmd>lua require('dap').toggle_breakpoint()<CR>",
                { desc = "Breakpoint Toggle" })
            vim.keymap.set("n", "<Leader>d6",
                "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
                { desc = "Breakpoint Condition" })
            vim.keymap.set("n", "<Leader>d7",
                "<cmd>lua require('dap').set_breakpoint( nil, nil, vim.fn.input('Log point message: ') )<CR>",
                { desc = "Breakpoint Log" })
            vim.keymap.set("n", "<Leader>d1", "<cmd>lua require('dap').continue()<CR>", { desc = "Continue" })
            vim.keymap.set("n", "<Leader>d2", "<cmd>lua require('dap').step_over()<CR>", { desc = "Step Over" })
            vim.keymap.set("n", "<Leader>d3", "<cmd>lua require('dap').step_into()<CR>", { desc = "Step Into" })
            vim.keymap.set("n", "<Leader>d4", "<cmd>lua require('dap').step_out()<CR>", { desc = "Step Out" })

            vim.keymap.set("n", "<Leader>de", "<cmd>lua require('dapui').eval()<CR>", { desc = "Eval" })
            vim.keymap.set("v", "<Leader>df", "<cmd>lua require('dapui').float_element()<CR>",
                { desc = "Float" })
            vim.keymap.set("n", "<Leader>d8", "<cmd>lua require('dap').repl.open()<CR>", { desc = "REPL Open" })
            vim.keymap.set("n", "<Leader>d9", "<cmd>lua require('dap').repl.run_last()<CR>", { desc = "REPL Run Last" })
        end
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end
    }
}
