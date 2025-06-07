-- Function to chop down elements between brackets
local function chop_down()
    local line_num = vim.fn.line(".")
    local col = vim.fn.col(".")
    local total_lines = vim.fn.line("$")

    -- Find the bracket pair that contains the cursor
    local bracket_pairs = {
        { open = "(", close = ")" },
        { open = "{", close = "}" },
        { open = "[", close = "]" }
    }

    local function find_multiline_bracket_range(start_line, start_col, open_char, close_char)
        local open_line, open_col = nil, nil
        local close_line, close_col = nil, nil
        local bracket_count = 0

        -- Find opening bracket (search backwards from cursor)
        for line_idx = start_line, 1, -1 do
            local line = vim.fn.getline(line_idx)
            local start_search = (line_idx == start_line) and start_col or #line

            for col_idx = start_search, 1, -1 do
                local char = line:sub(col_idx, col_idx)
                if char == close_char then
                    bracket_count = bracket_count + 1
                elseif char == open_char then
                    if bracket_count == 0 then
                        open_line, open_col = line_idx, col_idx
                        break
                    else
                        bracket_count = bracket_count - 1
                    end
                end
            end

            if open_line then break end
        end

        if not open_line then return nil end

        -- Find closing bracket (search forwards from opening bracket)
        bracket_count = 0
        for line_idx = open_line, total_lines do
            local line = vim.fn.getline(line_idx)
            local start_search = (line_idx == open_line) and (open_col + 1) or 1

            for col_idx = start_search, #line do
                local char = line:sub(col_idx, col_idx)
                if char == open_char then
                    bracket_count = bracket_count + 1
                elseif char == close_char then
                    if bracket_count == 0 then
                        close_line, close_col = line_idx, col_idx
                        break
                    else
                        bracket_count = bracket_count - 1
                    end
                end
            end

            if close_line then break end
        end

        return open_line, open_col, close_line, close_col
    end

    -- Try to find any bracket pair
    local open_line, open_col, close_line, close_col, open_char, close_char
    for _, pair in ipairs(bracket_pairs) do
        open_line, open_col, close_line, close_col = find_multiline_bracket_range(line_num, col, pair.open, pair.close)
        if open_line and close_line then
            open_char = pair.open
            close_char = pair.close
            break
        end
    end

    if not open_line or not close_line then
        print("No bracket pair found around cursor")
        return
    end

    -- Extract all content between brackets (across multiple lines)
    local content_lines = {}
    for i = open_line, close_line do
        local line = vim.fn.getline(i)
        if i == open_line and i == close_line then
            -- Both brackets on same line
            table.insert(content_lines, line:sub(open_col + 1, close_col - 1))
        elseif i == open_line then
            -- First line with opening bracket
            table.insert(content_lines, line:sub(open_col + 1))
        elseif i == close_line then
            -- Last line with closing bracket
            table.insert(content_lines, line:sub(1, close_col - 1))
        else
            -- Middle lines
            table.insert(content_lines, line)
        end
    end

    -- Join all content and split by commas
    local full_content = table.concat(content_lines, " ")
    local trimmed_content = full_content:match("^%s*(.-)%s*$")

    if trimmed_content == "" then
        return
    end

    -- Get indentation of the opening bracket line
    local opening_line = vim.fn.getline(open_line)
    local indent = opening_line:match("^%s*")
    local inner_indent = indent .. "    " -- Add 4 spaces for inner content

    -- Split content by commas and trim whitespace
    local elements = {}
    for element in full_content:gmatch("[^,]+") do
        local trimmed = element:match("^%s*(.-)%s*$")
        if trimmed ~= "" then
            table.insert(elements, trimmed)
        end
    end

    -- If no commas found, treat the whole content as one element
    if #elements == 0 then
        local trimmed = full_content:match("^%s*(.-)%s*$")
        if trimmed ~= "" then
            elements = { trimmed }
        end
    end

    -- Check if already fully chopped down (each element on its own line)
    local is_fully_chopped = false
    if open_line ~= close_line and close_line - open_line >= #elements then
        is_fully_chopped = true
        -- Verify each element is on its own line with proper indentation
        for i = 1, #elements do
            local element_line_num = open_line + i
            if element_line_num < close_line then
                local element_line = vim.fn.getline(element_line_num)
                local expected_element = elements[i]
                local expected_comma = (i < #elements) and "," or ""
                local expected_line = inner_indent .. expected_element .. expected_comma
                if element_line ~= expected_line then
                    is_fully_chopped = false
                    break
                end
            else
                is_fully_chopped = false
                break
            end
        end
    end

    -- Build new lines
    local new_lines = {}

    if is_fully_chopped then
        -- Toggle back to single line
        local before_bracket = opening_line:sub(1, open_col - 1)
        local closing_line = vim.fn.getline(close_line)
        local after_bracket = closing_line:sub(close_col + 1)
        local elements_str = table.concat(elements, ", ")
        table.insert(new_lines, before_bracket .. open_char .. elements_str .. close_char .. after_bracket)
    else
        -- Chop down to multiple lines
        local before_bracket = opening_line:sub(1, open_col - 1)
        table.insert(new_lines, before_bracket .. open_char)

        -- Elements (each on its own line)
        for i, element in ipairs(elements) do
            local comma = (i < #elements) and "," or ""
            table.insert(new_lines, inner_indent .. element .. comma)
        end

        -- Closing line: closing bracket + everything after
        local closing_line = vim.fn.getline(close_line)
        local after_bracket = closing_line:sub(close_col + 1)
        table.insert(new_lines, indent .. close_char .. after_bracket)
    end

    -- Delete the old lines and insert new ones
    if open_line == close_line then
        -- Single line case
        vim.fn.setline(open_line, new_lines[1])
        for i = 2, #new_lines do
            vim.fn.append(open_line + i - 2, new_lines[i])
        end
    else
        -- Multi-line case: delete old lines and insert new ones
        vim.fn.deletebufline("", open_line, close_line)
        for i = 1, #new_lines do
            vim.fn.append(open_line + i - 2, new_lines[i])
        end
    end

    -- Position cursor appropriately
    if is_fully_chopped then
        -- When toggling back to single line, position cursor at the end of the content
        vim.fn.cursor(open_line, #new_lines[1])
    elseif #elements > 0 then
        -- When chopping down, position cursor on the first element
        vim.fn.cursor(open_line + 1, #inner_indent + 1)
    end
end

-- Set up the keymap
vim.keymap.set(
    "n",
    "<Leader>cc",
    chop_down,
    { desc = "Chop Down" }
)
