return {
    {
        "mfussenegger/nvim-dap",
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        opts = {},
        config = function(_, opts)
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup(opts)
            vim.keymap.set("n", "<Leader>tdu", function()
                dapui.toggle()
            end, { desc = "DAP-UI" })
            vim.keymap.set("n", "<Leader>td5", function()
                dap.toggle_breakpoint()
            end, { desc = "Breakpoint Toggle" })
            vim.keymap.set("n", "<Leader>td6", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Breakpoint Condition" })
            vim.keymap.set("n", "<Leader>td7", function()
                dap.set_breakpoint(
                    nil,
                    nil,
                    vim.fn.input("Log point message: ")
                )
            end, { desc = "Breakpoint Log" })
            vim.keymap.set("n", "<Leader>td1", function()
                dap.continue()
            end, { desc = "Continue" })
            vim.keymap.set("n", "<Leader>td2", function()
                dap.step_over()
            end, { desc = "Step Over" })
            vim.keymap.set("n", "<Leader>td3", function()
                dap.step_into()
            end, { desc = "Step Into" })
            vim.keymap.set("n", "<Leader>td4", function()
                dap.step_out()
            end, { desc = "Step Out" })
            vim.keymap.set("n", "<Leader>tde", function()
                dapui.eval()
            end, { desc = "Eval" })
            vim.keymap.set("v", "<Leader>tdf", function()
                dapui.float_element()
            end, { desc = "Float" })
            vim.keymap.set("n", "<Leader>td8", function()
                dap.repl.open()
            end, { desc = "REPL Open" })
            vim.keymap.set("n", "<Leader>td9", function()
                dap.run_last()
            end, { desc = "Run Last" })
        end,
    },
}
