vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<Leader>bp", "<Cmd>bprevious<CR>", { desc = "Previous" })
vim.keymap.set("n", "<Leader>bn", "<Cmd>bnext<CR>", { desc = "Next" })
vim.keymap.set("n", "<Leader>bd", "<Cmd>bdelete<CR>", { desc = "Delete" })
vim.keymap.set("n", "<Leader>bt", function()
    if vim.fn.tabpagenr("$") == 1 then
        vim.cmd("tab split")
    else
        vim.cmd("tabclose")
    end
end, { desc = "Tab Split/Close Toggle" })

local function yank_and_notify(text)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { text })
    vim.api.nvim_buf_call(buf, function()
        vim.cmd("normal! 0y$")
    end)
    vim.api.nvim_buf_delete(buf, { force = true })
    vim.notify(("Yanked: " .. text))
    return text
end
local function relative_filepath()
    return vim.fn.expand("%:.")
end
local function absolute_filepath()
    return vim.fn.expand("%:p")
end
local function home_filepath()
    return vim.fn.expand("%:p:~")
end
local function reference_line(filepath)
    local line_number = vim.fn.line(".")
    return yank_and_notify(filepath .. ":" .. line_number)
end
local function reference_word(filepath)
    local word = vim.fn.expand("<cword>")
    local line_number = vim.fn.line(".")
    local word_with_filepath = (
        "`"
        .. word
        .. "` ("
        .. filepath
        .. ":"
        .. line_number
        .. ")"
    )
    return yank_and_notify(word_with_filepath)
end
local function reference_line_range(filepath)
    local start_line = vim.fn.getpos("v")[2]
    local end_line = vim.fn.line(".")
    local sorted_start = math.min(start_line, end_line)
    local sorted_end = math.max(start_line, end_line)
    local filepath_with_range = (
        filepath
        .. ":"
        .. sorted_start
        .. "-"
        .. sorted_end
    )
    return yank_and_notify(filepath_with_range)
end

vim.keymap.set("n", "<Leader>rl", function()
    return reference_line(relative_filepath())
end, { desc = "Reference Line" })
vim.keymap.set("n", "<Leader>ral", function()
    return reference_line(absolute_filepath())
end, { desc = "Reference Line (Absolute)" })
vim.keymap.set("n", "<Leader>rhl", function()
    return reference_line(home_filepath())
end, { desc = "Reference Line (Home)" })
vim.keymap.set("n", "<Leader>rf", function()
    return yank_and_notify(relative_filepath())
end, { desc = "Reference File" })
vim.keymap.set("n", "<Leader>raf", function()
    return yank_and_notify(absolute_filepath())
end, { desc = "Reference File (Absolute)" })
vim.keymap.set("n", "<Leader>rhf", function()
    return yank_and_notify(home_filepath())
end, { desc = "Reference File (Home)" })
vim.keymap.set("n", "<Leader>rw", function()
    return reference_word(relative_filepath())
end, { desc = "Reference Word" })
vim.keymap.set("n", "<Leader>raw", function()
    return reference_word(absolute_filepath())
end, { desc = "Reference Word (Absolute)" })
vim.keymap.set("n", "<Leader>rhw", function()
    return reference_word(home_filepath())
end, { desc = "Reference Word (Home)" })
vim.keymap.set("x", "<Leader>rv", function()
    return reference_line_range(relative_filepath())
end, { desc = "Reference Line Range" })
vim.keymap.set("x", "<Leader>rav", function()
    return reference_line_range(absolute_filepath())
end, { desc = "Reference Line Range (Absolute)" })
vim.keymap.set("x", "<Leader>rhv", function()
    return reference_line_range(home_filepath())
end, { desc = "Reference Line Range (Home)" })
