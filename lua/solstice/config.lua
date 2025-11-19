-- Solstice configuration module
-- Handles configuration parsing, validation, and defaults

local M = {}

-- Default configuration
local defaults = {
    -- Style preferences
    styles = {
        comments = { italic = true },
        keywords = { bold = false },
        functions = { bold = false },
        variables = { italic = false },
        strings = { italic = false },
    },

    -- Transparency settings
    transparent = {
        background = false,
        float = false,
        statusline = false,
    },

    -- Terminal colors (set terminal colors when theme loads)
    terminal_colors = true,

    -- Plugin integrations
    plugins = {
        telescope = true,
        nvim_tree = true,
        gitsigns = true,
        nvim_cmp = true,
        which_key = true,
        lsp = true,
        treesitter = true,
    },

    -- Custom color overrides
    -- Users can override any palette color
    -- Example: colors = { bg0 = '#000000', red = '#ff0000' }
    colors = {},

    -- Custom highlight group overrides
    -- Users can override any highlight group
    -- Example: overrides = { Comment = { fg = '#888888', italic = true } }
    overrides = {},
}

-- Current configuration (merged with user config)
local config = vim.deepcopy(defaults)

-- Validate hex color format
-- @param color string: Color value to validate
-- @return boolean: True if valid hex color
local function is_valid_hex_color(color)
    if type(color) ~= 'string' then
        return false
    end
    -- Match #RGB, #RRGGBB, or #RRGGBBAA format
    return color:match('^#%x%x%x$') ~= nil
        or color:match('^#%x%x%x%x%x%x$') ~= nil
        or color:match('^#%x%x%x%x%x%x%x%x$') ~= nil
end

-- Validate cterm color format
-- @param color number|string: Color value to validate
-- @return boolean: True if valid cterm color
local function is_valid_cterm_color(color)
    local num = tonumber(color)
    return num ~= nil and num >= 0 and num <= 255
end

-- Validate color definition
-- @param color_def table|string: Color definition to validate
-- @return boolean: True if valid
-- @return string|nil: Error message if invalid
local function validate_color_def(color_def)
    if type(color_def) == 'string' then
        if not is_valid_hex_color(color_def) then
            return false, string.format('Invalid hex color format: %s (expected #RRGGBB)', color_def)
        end
        return true
    end

    if type(color_def) == 'table' then
        if color_def.gui and not is_valid_hex_color(color_def.gui) then
            return false, string.format('Invalid gui color format: %s (expected #RRGGBB)', color_def.gui)
        end
        if color_def.cterm and not is_valid_cterm_color(color_def.cterm) then
            return false, string.format('Invalid cterm color: %s (expected 0-255)', color_def.cterm)
        end
        return true
    end

    return false, string.format('Invalid color definition type: %s (expected string or table)', type(color_def))
end

-- Validate highlight group definition
-- @param hl_def table: Highlight definition to validate
-- @return boolean: True if valid
-- @return string|nil: Error message if invalid
local function validate_highlight_def(hl_def)
    if type(hl_def) ~= 'table' then
        return false, string.format('Invalid highlight definition type: %s (expected table)', type(hl_def))
    end

    -- Validate color fields
    for _, field in ipairs({ 'fg', 'bg', 'sp' }) do
        if hl_def[field] then
            local valid, err = validate_color_def(hl_def[field])
            if not valid then
                return false, string.format('Invalid %s: %s', field, err)
            end
        end
    end

    -- Validate boolean attributes
    for _, attr in ipairs({ 'bold', 'italic', 'underline', 'undercurl', 'strikethrough', 'reverse' }) do
        if hl_def[attr] ~= nil and type(hl_def[attr]) ~= 'boolean' then
            return false, string.format('Invalid %s attribute: expected boolean, got %s', attr, type(hl_def[attr]))
        end
    end

    -- Validate link
    if hl_def.link and type(hl_def.link) ~= 'string' then
        return false, string.format('Invalid link: expected string, got %s', type(hl_def.link))
    end

    return true
end

-- Validate user configuration
-- @param user_config table: User-provided configuration
-- @return boolean: True if valid
-- @return string|nil: Error message if invalid
local function validate_config(user_config)
    if type(user_config) ~= 'table' then
        return false, 'Configuration must be a table'
    end

    -- Validate styles
    if user_config.styles then
        if type(user_config.styles) ~= 'table' then
            return false, 'styles must be a table'
        end
        for style_name, style_def in pairs(user_config.styles) do
            if type(style_def) ~= 'table' then
                return false, string.format('styles.%s must be a table', style_name)
            end
            for attr, value in pairs(style_def) do
                if type(value) ~= 'boolean' then
                    return false, string.format('styles.%s.%s must be a boolean', style_name, attr)
                end
            end
        end
    end

    -- Validate transparency
    if user_config.transparent then
        if type(user_config.transparent) ~= 'table' then
            return false, 'transparent must be a table'
        end
        for key, value in pairs(user_config.transparent) do
            if type(value) ~= 'boolean' then
                return false, string.format('transparent.%s must be a boolean', key)
            end
        end
    end

    -- Validate terminal_colors
    if user_config.terminal_colors ~= nil and type(user_config.terminal_colors) ~= 'boolean' then
        return false, 'terminal_colors must be a boolean'
    end

    -- Validate plugins
    if user_config.plugins then
        if type(user_config.plugins) ~= 'table' then
            return false, 'plugins must be a table'
        end
        for plugin, enabled in pairs(user_config.plugins) do
            if type(enabled) ~= 'boolean' then
                return false, string.format('plugins.%s must be a boolean', plugin)
            end
        end
    end

    -- Validate custom colors
    if user_config.colors then
        if type(user_config.colors) ~= 'table' then
            return false, 'colors must be a table'
        end
        for color_name, color_def in pairs(user_config.colors) do
            local valid, err = validate_color_def(color_def)
            if not valid then
                return false, string.format('colors.%s: %s', color_name, err)
            end
        end
    end

    -- Validate highlight overrides
    if user_config.overrides then
        if type(user_config.overrides) ~= 'table' then
            return false, 'overrides must be a table'
        end
        for group_name, hl_def in pairs(user_config.overrides) do
            local valid, err = validate_highlight_def(hl_def)
            if not valid then
                return false, string.format('overrides.%s: %s', group_name, err)
            end
        end
    end

    return true
end

-- Setup configuration with user options
-- @param user_config table: User-provided configuration
function M.setup(user_config)
    user_config = user_config or {}

    -- Validate user configuration
    local valid, err = validate_config(user_config)
    if not valid then
        vim.api.nvim_err_writeln(string.format('[Solstice] Configuration error: %s', err))
        vim.api.nvim_err_writeln('[Solstice] Using default configuration')
        config = vim.deepcopy(defaults)
        return
    end

    -- Merge user config with defaults
    config = vim.tbl_deep_extend('force', vim.deepcopy(defaults), user_config)
end

-- Get current configuration
-- @return table: Current configuration
function M.get()
    return config
end

-- Reset configuration to defaults
function M.reset()
    config = vim.deepcopy(defaults)
end

return M
