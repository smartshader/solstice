-- Solstice utility module
-- Helper functions for highlight setting and editor detection

local M = {}

-- Detect if running in Neovim
-- @return boolean: true if Neovim, false if Vim
function M.is_neovim()
    return vim.fn.has('nvim') == 1
end

-- Detect if running in Vim
-- @return boolean: true if Vim, false if Neovim
function M.is_vim()
    return vim.fn.has('nvim') == 0
end

-- Check if Vim version is at least the specified version
-- @param major number: Major version
-- @param minor number: Minor version
-- @param patch number: Patch version (optional)
-- @return boolean: true if version meets requirement
function M.has_vim_version(major, minor, patch)
    if M.is_neovim() then
        return false
    end

    -- Get Vim version
    local version_str = vim.fn.execute('version')
    local vim_major, vim_minor = version_str:match('VIM %- Vi IMproved (%d+)%.(%d+)')

    if not vim_major or not vim_minor then
        return false
    end

    vim_major = tonumber(vim_major)
    vim_minor = tonumber(vim_minor)

    if vim_major > major then
        return true
    elseif vim_major < major then
        return false
    end

    if vim_minor > minor then
        return true
    elseif vim_minor < minor then
        return false
    end

    if patch then
        local vim_patch = vim.fn.has('patch-' .. major .. '.' .. minor .. '.' .. patch)
        return vim_patch == 1
    end

    return true
end

-- Check if Lua is available in the current editor
-- @return boolean: true if Lua is available
function M.has_lua()
    return vim.fn.has('lua') == 1
end

-- Check editor compatibility for the theme
-- @return table: Compatibility information
function M.check_compatibility()
    local compat = {
        editor = M.is_neovim() and 'neovim' or 'vim',
        has_lua = M.has_lua(),
        can_use_theme = false,
        api_method = 'none',
        warnings = {},
    }

    if M.is_neovim() then
        -- Neovim compatibility
        if M.has_nvim_version(0, 5, 0) then
            compat.can_use_theme = true
            if M.has_nvim_version(0, 7, 0) then
                compat.api_method = 'nvim_set_hl'
            else
                compat.api_method = 'vim.cmd'
                table.insert(compat.warnings, 'Using vim.cmd for highlights (Neovim < 0.7)')
            end
        else
            table.insert(compat.warnings, 'Neovim version too old (< 0.5.0)')
        end
    else
        -- Vim compatibility
        if not compat.has_lua then
            table.insert(compat.warnings, 'Lua not available in Vim')
        elseif M.has_vim_version(8, 2, 0) then
            compat.can_use_theme = true
            compat.api_method = 'vim.cmd'
        else
            table.insert(compat.warnings, 'Vim version too old (< 8.2)')
        end
    end

    return compat
end

-- Check if Neovim version is at least the specified version
-- @param major number: Major version
-- @param minor number: Minor version
-- @param patch number: Patch version (optional)
-- @return boolean: true if version meets requirement
function M.has_nvim_version(major, minor, patch)
    if not M.is_neovim() then
        return false
    end

    local version = vim.version()
    if not version then
        return false
    end

    if version.major > major then
        return true
    elseif version.major < major then
        return false
    end

    if version.minor > minor then
        return true
    elseif version.minor < minor then
        return false
    end

    if patch then
        return version.patch >= patch
    end

    return true
end

-- Check terminal color capabilities
-- @return string: 'gui', 'cterm256', or 'cterm16'
function M.get_color_mode()
    -- Check for true color support (24-bit RGB)
    if vim.o.termguicolors then
        return 'gui'
    end

    -- Check terminal color count (only available in Vim, not Neovim)
    if M.is_vim() then
        local t_Co = vim.o.t_Co
        if t_Co and t_Co >= 256 then
            return 'cterm256'
        end
    else
        -- Neovim: if termguicolors is off, assume 256-color support
        return 'cterm256'
    end

    -- Fallback to 16-color mode
    return 'cterm16'
end

-- Set a highlight group using the appropriate method for the editor
-- @param group string: Highlight group name
-- @param colors table: Color and style definitions
--   - fg: foreground color (string or color table with gui/cterm)
--   - bg: background color (string or color table with gui/cterm)
--   - sp: special color for underline (string or color table with gui/cterm)
--   - bold: boolean
--   - italic: boolean
--   - underline: boolean
--   - undercurl: boolean
--   - strikethrough: boolean
--   - reverse: boolean
--   - link: string (link to another group, mutually exclusive with colors)
function M.set_highlight(group, colors)
    if not group or group == '' then
        return
    end

    -- Handle group linking
    if colors.link then
        if M.is_neovim() and M.has_nvim_version(0, 7, 0) then
            vim.api.nvim_set_hl(0, group, { link = colors.link })
        else
            -- Use vim.cmd for both Vim and older Neovim
            vim.cmd(string.format('highlight! link %s %s', group, colors.link))
        end
        return
    end

    -- Use Neovim's native API if available (0.7+)
    -- This is the preferred method for Neovim
    if M.is_neovim() and M.has_nvim_version(0, 7, 0) then
        local hl_def = {}
        local color_mode = M.get_color_mode()

        -- Set foreground color
        if colors.fg then
            hl_def.fg = M.get_color_value(colors.fg, color_mode)
        end

        -- Set background color
        if colors.bg then
            hl_def.bg = M.get_color_value(colors.bg, color_mode)
        end

        -- Set special color (for underline, undercurl)
        if colors.sp then
            hl_def.sp = M.get_color_value(colors.sp, color_mode)
        end

        -- Set text attributes
        if colors.bold then hl_def.bold = true end
        if colors.italic then hl_def.italic = true end
        if colors.underline then hl_def.underline = true end
        if colors.undercurl then hl_def.undercurl = true end
        if colors.strikethrough then hl_def.strikethrough = true end
        if colors.reverse then hl_def.reverse = true end

        vim.api.nvim_set_hl(0, group, hl_def)
    else
        -- Fallback to vim.cmd for Vim and older Neovim versions
        -- This method works in both Vim 8.2+ with Lua and older Neovim
        local cmd = 'highlight ' .. group
        local color_mode = M.get_color_mode()

        -- Add foreground color
        if colors.fg then
            local fg_value = M.get_color_value(colors.fg, color_mode)
            if color_mode == 'gui' then
                cmd = cmd .. ' guifg=' .. fg_value
            else
                cmd = cmd .. ' ctermfg=' .. fg_value
            end
        end

        -- Add background color
        if colors.bg then
            local bg_value = M.get_color_value(colors.bg, color_mode)
            if color_mode == 'gui' then
                cmd = cmd .. ' guibg=' .. bg_value
            else
                cmd = cmd .. ' ctermbg=' .. bg_value
            end
        end

        -- Add special color
        if colors.sp then
            local sp_value = M.get_color_value(colors.sp, color_mode)
            if color_mode == 'gui' then
                cmd = cmd .. ' guisp=' .. sp_value
            end
        end

        -- Add text attributes
        local attrs = {}
        if colors.bold then table.insert(attrs, 'bold') end
        if colors.italic then table.insert(attrs, 'italic') end
        if colors.underline then table.insert(attrs, 'underline') end
        if colors.undercurl then table.insert(attrs, 'undercurl') end
        if colors.strikethrough then table.insert(attrs, 'strikethrough') end
        if colors.reverse then table.insert(attrs, 'reverse') end

        if #attrs > 0 then
            local attr_str = table.concat(attrs, ',')
            if color_mode == 'gui' then
                cmd = cmd .. ' gui=' .. attr_str
            else
                cmd = cmd .. ' cterm=' .. attr_str
            end
        end

        vim.cmd(cmd)
    end
end

-- Extract the appropriate color value based on color mode
-- @param color string|table: Color value or color table with gui/cterm
-- @param color_mode string: 'gui', 'cterm256', or 'cterm16'
-- @return string: Color value appropriate for the mode
function M.get_color_value(color, color_mode)
    if type(color) == 'string' then
        return color
    end

    if type(color) == 'table' then
        if color_mode == 'gui' and color.gui then
            return color.gui
        elseif (color_mode == 'cterm256' or color_mode == 'cterm16') and color.cterm then
            return tostring(color.cterm)
        elseif color.gui then
            -- Fallback to gui color if cterm not available
            return color.gui
        end
    end

    return 'NONE'
end

-- Set terminal colors (for :terminal in Neovim/Vim)
-- @param colors table: Table with terminal color definitions (g:terminal_color_0 through g:terminal_color_15)
function M.set_terminal_colors(colors)
    if not colors then
        return
    end

    for i = 0, 15 do
        local key = 'terminal_color_' .. i
        if colors[key] then
            vim.g[key] = colors[key]
        end
    end
end

-- Clear all existing highlights
function M.clear_highlights()
    vim.cmd('highlight clear')
    if vim.fn.exists('syntax_on') == 1 then
        vim.cmd('syntax reset')
    end
end

return M
