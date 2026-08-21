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
vim.keymap.set({ "n", "x", "o" }, "<A-o>", function()
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
        require("vim.treesitter._select").select_parent(vim.v.count1)
    else
        vim.lsp.buf.selection_range(vim.v.count1)
    end
end, { desc = "Select Out" })
vim.keymap.set({ "n", "x", "o" }, "<A-i>", function()
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
        require("vim.treesitter._select").select_child(vim.v.count1)
    else
        vim.lsp.buf.selection_range(-vim.v.count1)
    end
end, { desc = "Select In" })

local function copy_and_notify(text)
    vim.fn.setreg("+", text)
    vim.notify(("Copied: " .. text))
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
    return copy_and_notify(filepath .. ":" .. line_number)
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
    return copy_and_notify(word_with_filepath)
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
    return copy_and_notify(filepath_with_range)
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
    return copy_and_notify(relative_filepath())
end, { desc = "Reference File" })
vim.keymap.set("n", "<Leader>raf", function()
    return copy_and_notify(absolute_filepath())
end, { desc = "Reference File (Absolute)" })
vim.keymap.set("n", "<Leader>rhf", function()
    return copy_and_notify(home_filepath())
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
