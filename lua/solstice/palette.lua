-- Solstice color palette module
-- Centralized color definitions with support for multiple color spaces

local M = {}

-- Helper function to create color definition
-- @param gui string: 24-bit RGB hex color (e.g., '#RRGGBB')
-- @param cterm number|string: 256-color palette index (0-255)
-- @return table: Color definition with gui and cterm values
local function color(gui, cterm)
    return { gui = gui, cterm = tostring(cterm) }
end

-- Get the color palette
-- @return table: Color definitions with gui and cterm values
function M.get_colors()
    local palette = {
        -- Base colors (backgrounds)
        bg0 = color('#050505', 232), -- Main background
        bg1 = color('#21252b', 235), -- Slightly lighter background
        bg2 = color('#282c34', 236), -- Lighter background (for popups, etc.)
        bg3 = color('#2f333d', 237), -- Even lighter (for selections)
        bg4 = color('#3e4451', 238), -- Lightest background shade

        -- Base colors (foregrounds)
        fg0 = color('#DADADA', 253), -- Main foreground
        fg1 = color('#c8ccd4', 251), -- Brighter foreground
        fg2 = color('#9196a1', 247), -- Dimmer foreground
        fg3 = color('#E5E4B5', 187), -- Even dimmer (for comments)

        -- Syntax colors - Primary
        red = color('#DD7CDB', 176),    -- Keywords, errors, deletion
        green = color('#BAEC7E', 150),  -- Strings, additions
        blue = color('#9ABBDD', 110),   -- Functions, identifiers
        yellow = color('#e5c07b', 180), -- Constants, warnings
        orange = color('#d19a66', 173), -- Numbers, special
        purple = color('#EA8675', 174), -- Types, keywords
        cyan = color('#56b6c2', 73),    -- Operators, special identifiers

        -- Syntax colors - Variants
        red_bright = color('#f0a3ee', 213),
        green_bright = color('#c9ff8f', 192),
        blue_bright = color('#aed4ff', 153),
        yellow_bright = color('#f0c674', 222),
        orange_bright = color('#e5a46b', 215),
        purple_bright = color('#ff9d8f', 210),
        cyan_bright = color('#2bbac5', 80),

        -- UI colors - Grays
        gray = color('#E5E4B5', 187), -- Comments, subtle UI
        gray_light = color('#6b7280', 243),
        gray_dark = color('#4b5263', 239),

        -- UI colors - Accents
        accent_blue = color('#9ABBDD', 110),
        accent_purple = color('#EA8675', 174),
        accent_cyan = color('#56b6c2', 73),

        -- Semantic colors
        error = color('#DD7CDB', 176),   -- Error messages
        warning = color('#e5c07b', 180), -- Warning messages
        info = color('#9ABBDD', 110),    -- Info messages
        hint = color('#56b6c2', 73),     -- Hint messages
        success = color('#BAEC7E', 150), -- Success messages

        -- Special UI colors
        selection = color('#3e4451', 238),   -- Visual selection
        search = color('#e5c07b', 180),      -- Search highlight
        search_bg = color('#3e4451', 238),   -- Search background
        match = color('#9ABBDD', 110),       -- Matching brackets
        cursor_line = color('#2c313c', 236), -- Current line
        cursor = color('#aed4ff', 153),      -- Cursor color

        -- Diff colors
        diff_add = color('#BAEC7E', 150),      -- Added lines
        diff_add_bg = color('#2c3a2e', 22),    -- Added background
        diff_change = color('#e5c07b', 180),   -- Changed lines
        diff_change_bg = color('#3a3a2e', 58), -- Changed background
        diff_delete = color('#DD7CDB', 176),   -- Deleted lines
        diff_delete_bg = color('#3a2c2e', 52), -- Deleted background
        diff_text = color('#9ABBDD', 110),     -- Changed text
        diff_text_bg = color('#2e3a4a', 17),   -- Changed text background

        -- Git colors
        git_add = color('#BAEC7E', 150),    -- Git additions
        git_change = color('#e5c07b', 180), -- Git modifications
        git_delete = color('#DD7CDB', 176), -- Git deletions
        git_text = color('#9ABBDD', 110),   -- Git text changes

        -- Border colors
        border = color('#3e4451', 238),           -- Window borders
        border_highlight = color('#9ABBDD', 110), -- Highlighted borders

        -- Special colors
        none = color('NONE', 'NONE'), -- Transparent/no color

        -- Terminal colors (for terminal emulator within vim/neovim)
        terminal_black = color('#050505', 232),
        terminal_red = color('#DD7CDB', 176),
        terminal_green = color('#BAEC7E', 150),
        terminal_yellow = color('#e5c07b', 180),
        terminal_blue = color('#9ABBDD', 110),
        terminal_magenta = color('#EA8675', 174),
        terminal_cyan = color('#56b6c2', 73),
        terminal_white = color('#DADADA', 253),
        terminal_bright_black = color('#5c6370', 241),
        terminal_bright_red = color('#f0a3ee', 213),
        terminal_bright_green = color('#c9ff8f', 192),
        terminal_bright_yellow = color('#f0c674', 222),
        terminal_bright_blue = color('#aed4ff', 153),
        terminal_bright_magenta = color('#ff9d8f', 210),
        terminal_bright_cyan = color('#2bbac5', 80),
        terminal_bright_white = color('#c8ccd4', 251),
    }

    return palette
end

return M
