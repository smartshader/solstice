-- Solstice theme main module
-- This module provides the public API for the theme

local M = {}

-- Setup function for user configuration
-- @param user_config table: User configuration options
--   - All standard config options (styles, transparent, terminal_colors, plugins, colors, overrides)
--   - load_now boolean: If true, load theme immediately after setup (default: false)
function M.setup(user_config)
    user_config = user_config or {}

    -- Extract load_now option before passing to config module
    local load_now = user_config.load_now

    -- Remove load_now from config table before passing to config module
    -- (it's not a theme configuration option, just a setup behavior flag)
    local theme_config = vim.deepcopy(user_config)
    theme_config.load_now = nil

    -- Setup configuration with user options
    local cfg = require('solstice.config')
    cfg.setup(theme_config)

    -- Load theme immediately if requested
    if load_now then
        M.load()
    end
end

-- Load the theme
-- This can be called manually by users or automatically via setup({ load_now = true })
function M.load()
    local theme = require('solstice.theme')
    theme.load()
end

return M
