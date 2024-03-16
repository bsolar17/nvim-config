vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function select_buf(n)
    local buffers = vim.api.nvim_command_output("buffers")
    local buf_list = vim.split(buffers, "\n")
    local buf_indexes_list = vim.tbl_map(function(buf) return tonumber(string.match(buf, "%d+")) end, buf_list)
    local buf_index = buf_indexes_list[n]
    if buf_index then
        vim.cmd("buffer " .. buf_index)
    end
end
for i = 1, 8 do
    vim.keymap.set("n", "<Leader>b" .. i, function() select_buf(i) end, { desc = tostring(i) })
end

vim.keymap.set("n", "<Leader>bp", "<cmd>bprevious<cr>", { desc = "Previous" })
vim.keymap.set("n", "<Leader>bn", "<cmd>bnext<cr>", { desc = "Next" })
vim.keymap.set("n", "<Leader>bd", "<cmd>bdelete<cr>", { desc = "Delete" })
