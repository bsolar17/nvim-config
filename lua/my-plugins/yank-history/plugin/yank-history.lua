-- Keeps "0 holding the latest yank or system copy, and an in-session history
-- of both. Neovim only puts yanks in "0; system copies are detected when focus
-- returns and the clipboard differs from when it was lost.
local HISTORY_LENGTH = 50

local history = {}

local function push(regcontents, regtype)
    for i, entry in ipairs(history) do
        if vim.deep_equal(entry.regcontents, regcontents) then
            table.remove(history, i)
            break
        end
    end
    table.insert(history, 1, { regcontents = regcontents, regtype = regtype })
    history[HISTORY_LENGTH + 1] = nil
end

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        if vim.v.event.operator == "y" then
            push(vim.v.event.regcontents, vim.v.event.regtype)
        end
    end,
})

local function clipboard_register()
    local clipboard = vim.opt.clipboard:get()
    if vim.tbl_contains(clipboard, "unnamedplus") then
        return "+"
    elseif vim.tbl_contains(clipboard, "unnamed") then
        return "*"
    end
end
local clipboard_on_focus_lost
vim.api.nvim_create_autocmd("FocusLost", {
    callback = function()
        local reg = clipboard_register()
        clipboard_on_focus_lost = reg and vim.fn.getreg(reg)
    end,
})
-- On VimEnter there is no snapshot yet, so a copy made before starting is
-- adopted too.
vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained" }, {
    callback = function()
        local reg = clipboard_register()
        if not reg then
            return
        end
        local clipboard = vim.fn.getreg(reg)
        if clipboard ~= "" and clipboard ~= clipboard_on_focus_lost then
            vim.fn.setreg("0", clipboard)
            local info = vim.fn.getreginfo("0")
            push(info.regcontents, info.regtype)
        end
    end,
})

vim.keymap.set("n", "<Leader>fy", function()
    vim.ui.select(history, {
        prompt = "Yank History",
        format_item = function(entry)
            local text = vim.trim(entry.regcontents[1] or "")
            return #entry.regcontents > 1 and text .. " …" or text
        end,
    }, function(entry)
        if entry then
            vim.fn.setreg("0", entry.regcontents, entry.regtype)
            vim.cmd("normal! \"0p")
        end
    end)
end, { desc = "Yank History" })
