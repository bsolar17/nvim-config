-- Function to chop down elements between brackets
local function chop_brackets()
    local line_num = vim.fn.line(".")
    local line = vim.fn.getline(line_num)
    local col = vim.fn.col(".")

    -- Find the bracket pair that contains the cursor
    local bracket_pairs = {
        { open = "(", close = ")" },
        { open = "{", close = "}" },
        { open = "[", close = "]" }
    }

    local function find_bracket_range(line, col, open_char, close_char)
        local open_pos = nil
        local close_pos = nil
        local bracket_count = 0

        -- Find the opening bracket to the left of cursor
        for i = col, 1, -1 do
            local char = line:sub(i, i)
            if char == close_char then
                bracket_count = bracket_count + 1
            elseif char == open_char then
                if bracket_count == 0 then
                    open_pos = i
                    break
                else
                    bracket_count = bracket_count - 1
                end
            end
        end

        if not open_pos then return nil end

        -- Find the closing bracket to the right
        bracket_count = 0
        for i = open_pos + 1, #line do
            local char = line:sub(i, i)
            if char == open_char then
                bracket_count = bracket_count + 1
            elseif char == close_char then
                if bracket_count == 0 then
                    close_pos = i
                    break
                else
                    bracket_count = bracket_count - 1
                end
            end
        end

        return open_pos, close_pos
    end

    -- Try to find any bracket pair
    local open_pos, close_pos, open_char, close_char
    for _, pair in ipairs(bracket_pairs) do
        open_pos, close_pos = find_bracket_range(line, col, pair.open, pair.close)
        if open_pos and close_pos then
            open_char = pair.open
            close_char = pair.close
            break
        end
    end

    if not open_pos or not close_pos then
        print("No bracket pair found around cursor")
        return
    end

    -- Extract content between brackets
    local content = line:sub(open_pos + 1, close_pos - 1)

    -- Skip if already multiline or empty
    local trimmed_content = content:match("^%s*(.-)%s*$")
    if content:match("\n") or trimmed_content == "" then
        return
    end

    -- Get indentation of current line
    local indent = line:match("^%s*")
    local inner_indent = indent .. "    " -- Add 4 spaces for inner content

    -- Split content by commas and trim whitespace
    local elements = {}
    for element in content:gmatch("[^,]+") do
        local trimmed = element:match("^%s*(.-)%s*$")
        if trimmed ~= "" then
            table.insert(elements, trimmed)
        end
    end

    -- If no commas found, treat the whole content as one element
    if #elements == 0 then
        local trimmed = content:match("^%s*(.-)%s*$")
        if trimmed ~= "" then
            elements = { trimmed }
        end
    end

    -- Build new lines
    local new_lines = {}

    -- Opening line: everything before opening bracket + opening bracket
    local before_bracket = line:sub(1, open_pos - 1)
    table.insert(new_lines, before_bracket .. open_char)

    -- Elements (each on its own line)
    for i, element in ipairs(elements) do
        local comma = (i < #elements) and "," or ""
        table.insert(new_lines, inner_indent .. element .. comma)
    end

    -- Closing line: closing bracket + everything after
    local after_bracket = line:sub(close_pos + 1)
    table.insert(new_lines, indent .. close_char .. after_bracket)

    -- Replace the current line with new lines
    vim.fn.setline(line_num, new_lines[1])
    for i = 2, #new_lines do
        vim.fn.append(line_num + i - 2, new_lines[i])
    end

    -- Position cursor on the first element
    if #elements > 0 then
        vim.fn.cursor(line_num + 1, #inner_indent + 1)
    end
end

-- Set up the keymap
vim.keymap.set(
    "n",
    "<Leader>cc",
    chop_brackets,
    { desc = "Chop brackets" }
)
