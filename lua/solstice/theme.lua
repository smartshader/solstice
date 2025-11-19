-- Solstice theme loading module
-- Handles theme initialization and highlight application

local M = {}

-- Load and apply the theme
function M.load()
    local util = require('solstice.util')
    local config = require('solstice.config')
    local palette = require('solstice.palette')
    local highlights = require('solstice.highlights')

    -- Check compatibility
    local compat = util.check_compatibility()

    if not compat.can_use_theme then
        local msg = 'Solstice theme cannot be loaded: ' .. table.concat(compat.warnings, ', ')
        if util.is_neovim() then
            vim.api.nvim_err_writeln(msg)
        else
            vim.cmd('echohl ErrorMsg | echom "' .. msg .. '" | echohl None')
        end
        return
    end

    -- Show warnings if any
    if #compat.warnings > 0 then
        for _, warning in ipairs(compat.warnings) do
            if util.is_neovim() then
                vim.notify('Solstice: ' .. warning, vim.log.levels.WARN)
            else
                vim.cmd('echohl WarningMsg | echom "Solstice: ' .. warning .. '" | echohl None')
            end
        end
    end

    -- Clear existing highlights
    util.clear_highlights()

    -- Set colorscheme name
    vim.g.colors_name = 'solstice'

    -- Get configuration
    local cfg = config.get()

    -- Get color palette
    local colors = palette.get_colors()

    -- Get all highlight groups
    local groups = highlights.get_groups(colors, cfg)

    -- Apply syntax highlight groups
    for group, def in pairs(groups.syntax) do
        util.set_highlight(group, def)
    end

    -- Apply editor UI highlight groups
    for group, def in pairs(groups.editor) do
        util.set_highlight(group, def)
    end

    -- Apply Vim-specific highlight groups
    for group, def in pairs(groups.vim) do
        util.set_highlight(group, def)
    end

    -- Apply Neovim-specific highlight groups
    for group, def in pairs(groups.neovim) do
        util.set_highlight(group, def)
    end

    -- Apply tree-sitter highlight groups
    for group, def in pairs(groups.treesitter) do
        util.set_highlight(group, def)
    end

    -- Apply plugin-specific highlight groups
    for group, def in pairs(groups.plugins) do
        util.set_highlight(group, def)
    end

    -- Set terminal colors if supported
    if cfg.terminal_colors and (util.is_neovim() or vim.fn.has('terminal') == 1) then
        local terminal_colors = {
            terminal_color_0 = util.get_color_value(colors.terminal_black, 'gui'),
            terminal_color_1 = util.get_color_value(colors.terminal_red, 'gui'),
            terminal_color_2 = util.get_color_value(colors.terminal_green, 'gui'),
            terminal_color_3 = util.get_color_value(colors.terminal_yellow, 'gui'),
            terminal_color_4 = util.get_color_value(colors.terminal_blue, 'gui'),
            terminal_color_5 = util.get_color_value(colors.terminal_magenta, 'gui'),
            terminal_color_6 = util.get_color_value(colors.terminal_cyan, 'gui'),
            terminal_color_7 = util.get_color_value(colors.terminal_white, 'gui'),
            terminal_color_8 = util.get_color_value(colors.terminal_bright_black, 'gui'),
            terminal_color_9 = util.get_color_value(colors.terminal_bright_red, 'gui'),
            terminal_color_10 = util.get_color_value(colors.terminal_bright_green, 'gui'),
            terminal_color_11 = util.get_color_value(colors.terminal_bright_yellow, 'gui'),
            terminal_color_12 = util.get_color_value(colors.terminal_bright_blue, 'gui'),
            terminal_color_13 = util.get_color_value(colors.terminal_bright_magenta, 'gui'),
            terminal_color_14 = util.get_color_value(colors.terminal_bright_cyan, 'gui'),
            terminal_color_15 = util.get_color_value(colors.terminal_bright_white, 'gui'),
        }
        util.set_terminal_colors(terminal_colors)
    end
end

return M
