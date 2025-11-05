local M = {}

-- Function to chop down elements between brackets
function M.chop_down()
    local line_num = vim.fn.line(".")
    local col = vim.fn.col(".")
    local total_lines = vim.fn.line("$")

    -- Find the bracket pair that contains the cursor
    local bracket_pairs = {
        { open = "(", close = ")" },
        { open = "{", close = "}" },
        { open = "[", close = "]" },
    }

    local function find_multiline_bracket_range(
        start_line,
        start_col,
        open_char,
        close_char
    )
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

            if open_line then
                break
            end
        end

        if not open_line then
            return nil
        end

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

            if close_line then
                break
            end
        end

        return open_line, open_col, close_line, close_col
    end

    -- Try to find any bracket pair
    local open_line, open_col, close_line, close_col, open_char, close_char
    for _, pair in ipairs(bracket_pairs) do
        open_line, open_col, close_line, close_col =
            find_multiline_bracket_range(line_num, col, pair.open, pair.close)
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

    -- Extract content between brackets
    local content_lines = {}
    for line_idx = open_line, close_line do
        local line = vim.fn.getline(line_idx)
        if line_idx == open_line and line_idx == close_line then
            table.insert(content_lines, line:sub(open_col + 1, close_col - 1))
        elseif line_idx == open_line then
            table.insert(content_lines, line:sub(open_col + 1))
        elseif line_idx == close_line then
            table.insert(content_lines, line:sub(1, close_col - 1))
        else
            table.insert(content_lines, line)
        end
    end

    local full_content = table.concat(content_lines, " ")
    local trimmed_content = full_content:match("^%s*(.-)%s*$")

    if trimmed_content == "" then
        return
    end

    -- Get indentation
    local opening_line = vim.fn.getline(open_line)
    local indent = opening_line:match("^%s*")
    local inner_indent = indent .. "    "

    -- Split content by commas while respecting nested brackets
    local elements = {}
    local current_element = ""
    local bracket_depth = 0

    for char_idx = 1, #full_content do
        local char = full_content:sub(char_idx, char_idx)

        if char == "(" or char == "{" or char == "[" then
            bracket_depth = bracket_depth + 1
            current_element = current_element .. char
        elseif char == ")" or char == "}" or char == "]" then
            bracket_depth = bracket_depth - 1
            current_element = current_element .. char
        elseif char == "," and bracket_depth == 0 then
            local trimmed = current_element:match("^%s*(.-)%s*$")
            if trimmed ~= "" then
                table.insert(elements, trimmed)
            end
            current_element = ""
        else
            current_element = current_element .. char
        end
    end

    -- Add last element
    if current_element ~= "" then
        local trimmed = current_element:match("^%s*(.-)%s*$")
        if trimmed ~= "" then
            table.insert(elements, trimmed)
        end
    end

    -- If no elements found, treat whole content as one element
    if #elements == 0 then
        local trimmed = full_content:match("^%s*(.-)%s*$")
        if trimmed ~= "" then
            elements = { trimmed }
        end
    end

    -- Check if already fully chopped down
    local is_fully_chopped = false
    if open_line ~= close_line and close_line - open_line >= #elements then
        is_fully_chopped = true
        for elem_idx = 1, #elements do
            local element_line_num = open_line + elem_idx
            if element_line_num < close_line then
                local element_line = vim.fn.getline(element_line_num)
                local expected_comma = (elem_idx < #elements) and "," or ""
                local expected_line = inner_indent
                    .. elements[elem_idx]
                    .. expected_comma
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
        table.insert(
            new_lines,
            before_bracket
                .. open_char
                .. elements_str
                .. close_char
                .. after_bracket
        )
    else
        -- Chop down to multiple lines
        local before_bracket = opening_line:sub(1, open_col - 1)
        table.insert(new_lines, before_bracket .. open_char)

        for elem_idx, element in ipairs(elements) do
            local comma = (elem_idx < #elements) and "," or ""
            table.insert(new_lines, inner_indent .. element .. comma)
        end

        local closing_line = vim.fn.getline(close_line)
        local after_bracket = closing_line:sub(close_col + 1)
        table.insert(new_lines, indent .. close_char .. after_bracket)
    end

    -- Replace lines
    if open_line == close_line then
        vim.fn.setline(open_line, new_lines[1])
        for new_idx = 2, #new_lines do
            vim.fn.append(open_line + new_idx - 2, new_lines[new_idx])
        end
    else
        vim.fn.deletebufline("", open_line, close_line)
        for new_idx = 1, #new_lines do
            vim.fn.append(open_line + new_idx - 2, new_lines[new_idx])
        end
    end

    -- Position cursor
    if is_fully_chopped then
        vim.fn.cursor(open_line, #new_lines[1])
    elseif #elements > 0 then
        vim.fn.cursor(open_line + 1, #inner_indent + 1)
    end
end

function M.setup() end

return M
