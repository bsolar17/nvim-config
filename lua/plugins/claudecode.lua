require("claudecode").setup()

vim.keymap.set("n", "<leader>a", "<Nop>", { desc = "AI" })
vim.keymap.set("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Claude" })
vim.keymap.set(
    "n",
    "<leader>af",
    "<cmd>ClaudeCodeFocus<cr>",
    { desc = "Focus Claude" }
)
vim.keymap.set(
    "n",
    "<leader>ar",
    "<cmd>ClaudeCode --resume<cr>",
    { desc = "Resume Claude" }
)
vim.keymap.set(
    "n",
    "<leader>aC",
    "<cmd>ClaudeCode --continue<cr>",
    { desc = "Continue Claude" }
)
vim.keymap.set(
    "n",
    "<leader>am",
    "<cmd>ClaudeCodeSelectModel<cr>",
    { desc = "Select Claude model" }
)
vim.keymap.set(
    "n",
    "<leader>ab",
    "<cmd>ClaudeCodeAdd %<cr>",
    { desc = "Add current buffer" }
)
vim.keymap.set(
    "v",
    "<leader>as",
    "<cmd>ClaudeCodeSend<cr>",
    { desc = "Send to Claude" }
)
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "NvimTree",
        "neo-tree",
        "oil",
        "minifiles",
        "netrw",
        "snacks_picker_list",
    },
    callback = function(ev)
        vim.keymap.set(
            "n",
            "<leader>as",
            "<cmd>ClaudeCodeTreeAdd<cr>",
            { buffer = ev.buf, desc = "Add file" }
        )
    end,
})
vim.keymap.set(
    "n",
    "<leader>aa",
    "<cmd>ClaudeCodeDiffAccept<cr>",
    { desc = "Accept diff" }
)
vim.keymap.set(
    "n",
    "<leader>ad",
    "<cmd>ClaudeCodeDiffDeny<cr>",
    { desc = "Deny diff" }
)
