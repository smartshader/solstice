-- Solstice highlight groups module
-- Defines all highlight groups organized by category

local M = {}

-- Get all highlight group definitions
-- @param colors table: Color palette from palette module
-- @param config table: Configuration options
-- @return table: Highlight groups organized by category
function M.get_groups(colors, config)
    local syntax = {}
    local editor = {}
    local plugins = {}

    -- Standard Vim syntax highlight groups
    -- Comments
    syntax.Comment = {
        fg = colors.gray,
        italic = config.styles.comments.italic,
    }

    -- Constants
    syntax.Constant = { fg = colors.orange }
    syntax.String = {
        fg = colors.green,
        italic = config.styles.strings.italic,
    }
    syntax.Character = { fg = colors.green }
    syntax.Number = { fg = colors.orange }
    syntax.Boolean = { fg = colors.orange }
    syntax.Float = { fg = colors.orange }

    -- Identifiers
    syntax.Identifier = {
        fg = colors.red,
        italic = config.styles.variables.italic,
    }
    syntax.Function = {
        fg = colors.blue,
        bold = config.styles.functions.bold,
    }

    -- Statements
    syntax.Statement = {
        fg = colors.purple,
        bold = config.styles.keywords.bold,
    }
    syntax.Conditional = {
        fg = colors.purple,
        bold = config.styles.keywords.bold,
    }
    syntax.Repeat = {
        fg = colors.purple,
        bold = config.styles.keywords.bold,
    }
    syntax.Label = {
        fg = colors.purple,
        bold = config.styles.keywords.bold,
    }
    syntax.Operator = { fg = colors.cyan }
    syntax.Keyword = {
        fg = colors.purple,
        bold = config.styles.keywords.bold,
    }
    syntax.Exception = {
        fg = colors.purple,
        bold = config.styles.keywords.bold,
    }

    -- PreProc
    syntax.PreProc = { fg = colors.yellow }
    syntax.Include = { fg = colors.purple }
    syntax.Define = { fg = colors.purple }
    syntax.Macro = { fg = colors.cyan }
    syntax.PreCondit = { fg = colors.yellow }

    -- Types
    syntax.Type = { fg = colors.yellow }
    syntax.StorageClass = { fg = colors.yellow }
    syntax.Structure = { fg = colors.yellow }
    syntax.Typedef = { fg = colors.yellow }

    -- Special
    syntax.Special = { fg = colors.cyan }
    syntax.SpecialChar = { fg = colors.orange }
    syntax.Tag = { fg = colors.cyan }
    syntax.Delimiter = { fg = colors.fg0 }
    syntax.SpecialComment = {
        fg = colors.gray_light,
        italic = true,
    }
    syntax.Debug = { fg = colors.red }

    -- Other
    syntax.Underlined = {
        fg = colors.blue,
        underline = true,
    }
    syntax.Ignore = { fg = colors.gray_dark }
    syntax.Error = {
        fg = colors.error,
        bold = true,
    }
    syntax.Todo = {
        fg = colors.bg0,
        bg = colors.yellow,
        bold = true,
    }

    -- Editor UI highlight groups
    -- Normal and window groups
    editor.Normal = {
        fg = colors.fg0,
        bg = colors.bg0,
    }
    editor.NormalFloat = {
        fg = colors.fg0,
        bg = colors.bg2,
    }
    editor.NormalNC = {
        fg = colors.fg0,
        bg = colors.bg0,
    }

    -- Cursor groups
    editor.Cursor = {
        fg = colors.bg0,
        bg = colors.cursor,
    }
    editor.CursorLine = {
        bg = colors.cursor_line,
    }
    editor.CursorColumn = {
        bg = colors.cursor_line,
    }
    editor.CursorLineNr = {
        fg = colors.yellow,
        bold = true,
    }

    -- Line number and column groups
    editor.LineNr = {
        fg = colors.gray,
    }
    editor.SignColumn = {
        fg = colors.gray,
        bg = colors.bg0,
    }
    editor.FoldColumn = {
        fg = colors.gray,
        bg = colors.bg0,
    }
    editor.Folded = {
        fg = colors.gray_light,
        bg = colors.bg2,
        italic = true,
    }

    -- Status line and tab line groups
    editor.StatusLine = {
        fg = colors.fg0,
        bg = colors.bg2,
    }
    editor.StatusLineNC = {
        fg = colors.gray,
        bg = colors.bg1,
    }
    editor.TabLine = {
        fg = colors.gray,
        bg = colors.bg1,
    }
    editor.TabLineFill = {
        bg = colors.bg1,
    }
    editor.TabLineSel = {
        fg = colors.fg0,
        bg = colors.bg3,
        bold = true,
    }

    -- Visual and search groups
    editor.Visual = {
        bg = colors.selection,
    }
    editor.VisualNOS = {
        bg = colors.selection,
    }
    editor.Search = {
        fg = colors.bg0,
        bg = colors.search,
    }
    editor.IncSearch = {
        fg = colors.bg0,
        bg = colors.orange,
    }
    editor.CurSearch = {
        fg = colors.bg0,
        bg = colors.orange,
    }

    -- Popup menu groups
    editor.Pmenu = {
        fg = colors.fg0,
        bg = colors.bg2,
    }
    editor.PmenuSel = {
        fg = colors.bg0,
        bg = colors.blue,
        bold = true,
    }
    editor.PmenuSbar = {
        bg = colors.bg3,
    }
    editor.PmenuThumb = {
        bg = colors.gray,
    }

    -- Window separator groups
    editor.VertSplit = {
        fg = colors.border,
        bg = colors.bg0,
    }
    editor.WinSeparator = {
        fg = colors.border,
        bg = colors.bg0,
    }

    -- Diff groups
    editor.DiffAdd = {
        fg = colors.diff_add,
        bg = colors.diff_add_bg,
    }
    editor.DiffChange = {
        fg = colors.diff_change,
        bg = colors.diff_change_bg,
    }
    editor.DiffDelete = {
        fg = colors.diff_delete,
        bg = colors.diff_delete_bg,
    }
    editor.DiffText = {
        fg = colors.diff_text,
        bg = colors.diff_text_bg,
        bold = true,
    }

    -- Spell checking groups
    editor.SpellBad = {
        sp = colors.error,
        underline = true,
    }
    editor.SpellCap = {
        sp = colors.warning,
        underline = true,
    }
    editor.SpellRare = {
        sp = colors.hint,
        underline = true,
    }
    editor.SpellLocal = {
        sp = colors.info,
        underline = true,
    }

    -- Vim-specific UI highlight groups
    -- Only apply when running in Vim (not Neovim)
    local vimgroups = {}
    if vim.fn.has('nvim') == 0 then
        -- Vim-specific popup menu groups
        -- In Vim 8.2+, popup windows have different highlight groups
        vimgroups.Popup = {
            fg = colors.fg0,
            bg = colors.bg2,
        }
        vimgroups.PopupSelected = {
            fg = colors.bg0,
            bg = colors.blue,
            bold = true,
        }

        -- Vim-specific terminal groups
        vimgroups.Terminal = {
            fg = colors.fg0,
            bg = colors.bg0,
        }

        -- Vim-specific quickfix groups
        vimgroups.QuickFixLine = {
            fg = colors.fg0,
            bg = colors.selection,
            bold = true,
        }

        -- Vim-specific message area groups
        vimgroups.MsgArea = {
            fg = colors.fg0,
            bg = colors.bg0,
        }
        vimgroups.MsgSeparator = {
            fg = colors.border,
            bg = colors.bg1,
        }
    end

    -- Neovim-specific UI and LSP highlight groups
    -- Only apply when running in Neovim
    local neovim = {}
    if vim.fn.has('nvim') == 1 then
        -- Floating window groups
        neovim.FloatBorder = {
            fg = colors.border_highlight,
            bg = colors.bg2,
        }
        neovim.FloatTitle = {
            fg = colors.accent_blue,
            bg = colors.bg2,
            bold = true,
        }

        -- LSP Diagnostic groups
        neovim.DiagnosticError = {
            fg = colors.error,
        }
        neovim.DiagnosticWarn = {
            fg = colors.warning,
        }
        neovim.DiagnosticInfo = {
            fg = colors.info,
        }
        neovim.DiagnosticHint = {
            fg = colors.hint,
        }

        -- LSP Diagnostic underline groups
        neovim.DiagnosticUnderlineError = {
            sp = colors.error,
            undercurl = true,
        }
        neovim.DiagnosticUnderlineWarn = {
            sp = colors.warning,
            undercurl = true,
        }
        neovim.DiagnosticUnderlineInfo = {
            sp = colors.info,
            undercurl = true,
        }
        neovim.DiagnosticUnderlineHint = {
            sp = colors.hint,
            undercurl = true,
        }

        -- LSP Reference groups
        neovim.LspReferenceText = {
            bg = colors.bg3,
        }
        neovim.LspReferenceRead = {
            bg = colors.bg3,
        }
        neovim.LspReferenceWrite = {
            bg = colors.bg3,
            underline = true,
        }

        -- LSP Signature help
        neovim.LspSignatureActiveParameter = {
            fg = colors.accent_blue,
            bold = true,
        }
    end

    -- Tree-sitter semantic token highlight groups
    -- Only apply when tree-sitter is available
    local treesitter = {}
    if vim.fn.has('nvim-0.5') == 1 then
        -- Variables
        treesitter['@variable'] = {
            fg = colors.red,
            italic = config.styles.variables.italic,
        }
        treesitter['@variable.builtin'] = {
            fg = colors.red,
            italic = true,
        }
        treesitter['@variable.parameter'] = {
            fg = colors.red,
            italic = config.styles.variables.italic,
        }

        -- Constants
        treesitter['@constant'] = { fg = colors.orange }
        treesitter['@constant.builtin'] = {
            fg = colors.orange,
            bold = true,
        }
        treesitter['@constant.macro'] = { fg = colors.cyan }

        -- Strings
        treesitter['@string'] = {
            fg = colors.green,
            italic = config.styles.strings.italic,
        }
        treesitter['@string.escape'] = {
            fg = colors.cyan,
            bold = true,
        }
        treesitter['@string.special'] = {
            fg = colors.cyan,
        }

        -- Character and number types
        treesitter['@character'] = { fg = colors.green }
        treesitter['@number'] = { fg = colors.orange }
        treesitter['@boolean'] = { fg = colors.orange }
        treesitter['@float'] = { fg = colors.orange }

        -- Functions
        treesitter['@function'] = {
            fg = colors.blue,
            bold = config.styles.functions.bold,
        }
        treesitter['@function.builtin'] = {
            fg = colors.blue,
            bold = true,
        }
        treesitter['@function.macro'] = {
            fg = colors.cyan,
        }

        -- Keywords
        treesitter['@keyword'] = {
            fg = colors.purple,
            bold = config.styles.keywords.bold,
        }
        treesitter['@keyword.function'] = {
            fg = colors.purple,
            bold = config.styles.keywords.bold,
        }
        treesitter['@keyword.operator'] = {
            fg = colors.purple,
            bold = config.styles.keywords.bold,
        }
        treesitter['@keyword.return'] = {
            fg = colors.purple,
            bold = config.styles.keywords.bold,
        }

        -- Operators and punctuation
        treesitter['@operator'] = { fg = colors.cyan }
        treesitter['@punctuation.delimiter'] = { fg = colors.fg0 }
        treesitter['@punctuation.bracket'] = { fg = colors.fg0 }

        -- Types
        treesitter['@type'] = { fg = colors.yellow }
        treesitter['@type.builtin'] = {
            fg = colors.yellow,
            bold = true,
        }
        treesitter['@type.definition'] = {
            fg = colors.yellow,
        }

        -- Comments
        treesitter['@comment'] = {
            fg = colors.gray,
            italic = config.styles.comments.italic,
        }
        treesitter['@comment.documentation'] = {
            fg = colors.gray_light,
            italic = true,
        }
    end

    -- Plugin integration highlight groups
    -- Telescope.nvim
    plugins.TelescopeBorder = {
        fg = colors.border_highlight,
        bg = colors.bg2,
    }
    plugins.TelescopePromptBorder = {
        fg = colors.border_highlight,
        bg = colors.bg2,
    }
    plugins.TelescopeResultsBorder = {
        fg = colors.border_highlight,
        bg = colors.bg2,
    }
    plugins.TelescopePreviewBorder = {
        fg = colors.border_highlight,
        bg = colors.bg2,
    }
    plugins.TelescopeSelection = {
        fg = colors.fg0,
        bg = colors.selection,
        bold = true,
    }
    plugins.TelescopeSelectionCaret = {
        fg = colors.accent_blue,
        bg = colors.selection,
    }
    plugins.TelescopeMultiSelection = {
        fg = colors.purple,
        bg = colors.selection,
    }
    plugins.TelescopeNormal = { link = 'NormalFloat' }
    plugins.TelescopePromptPrefix = {
        fg = colors.accent_blue,
    }
    plugins.TelescopeMatching = {
        fg = colors.orange,
        bold = true,
    }

    -- nvim-tree
    plugins.NvimTreeFolderName = {
        fg = colors.blue,
    }
    plugins.NvimTreeFolderIcon = {
        fg = colors.blue,
    }
    plugins.NvimTreeOpenedFolderName = {
        fg = colors.blue,
        bold = true,
    }
    plugins.NvimTreeEmptyFolderName = {
        fg = colors.gray,
    }
    plugins.NvimTreeRootFolder = {
        fg = colors.purple,
        bold = true,
    }
    plugins.NvimTreeSpecialFile = {
        fg = colors.yellow,
        underline = true,
    }
    plugins.NvimTreeExecFile = {
        fg = colors.green,
        bold = true,
    }
    plugins.NvimTreeImageFile = {
        fg = colors.purple,
    }
    plugins.NvimTreeGitDirty = {
        fg = colors.diff_change,
    }
    plugins.NvimTreeGitStaged = {
        fg = colors.diff_add,
    }
    plugins.NvimTreeGitMerge = {
        fg = colors.orange,
    }
    plugins.NvimTreeGitRenamed = {
        fg = colors.purple,
    }
    plugins.NvimTreeGitNew = {
        fg = colors.diff_add,
    }
    plugins.NvimTreeGitDeleted = {
        fg = colors.diff_delete,
    }
    plugins.NvimTreeIndentMarker = {
        fg = colors.gray_dark,
    }
    plugins.NvimTreeSymlink = {
        fg = colors.cyan,
    }
    plugins.NvimTreeNormal = { link = 'Normal' }
    plugins.NvimTreeNormalNC = { link = 'NormalNC' }

    -- Gitsigns
    plugins.GitSignsAdd = {
        fg = colors.diff_add,
    }
    plugins.GitSignsChange = {
        fg = colors.diff_change,
    }
    plugins.GitSignsDelete = {
        fg = colors.diff_delete,
    }
    plugins.GitSignsAddNr = {
        fg = colors.diff_add,
    }
    plugins.GitSignsChangeNr = {
        fg = colors.diff_change,
    }
    plugins.GitSignsDeleteNr = {
        fg = colors.diff_delete,
    }
    plugins.GitSignsAddLn = {
        bg = colors.diff_add_bg,
    }
    plugins.GitSignsChangeLn = {
        bg = colors.diff_change_bg,
    }
    plugins.GitSignsDeleteLn = {
        bg = colors.diff_delete_bg,
    }

    -- nvim-cmp (completion menu)
    plugins.CmpItemAbbrDeprecated = {
        fg = colors.gray,
        strikethrough = true,
    }
    plugins.CmpItemAbbrMatch = {
        fg = colors.blue,
        bold = true,
    }
    plugins.CmpItemAbbrMatchFuzzy = {
        fg = colors.blue,
    }
    plugins.CmpItemKindVariable = {
        fg = colors.red,
    }
    plugins.CmpItemKindInterface = {
        fg = colors.yellow,
    }
    plugins.CmpItemKindText = {
        fg = colors.fg0,
    }
    plugins.CmpItemKindFunction = {
        fg = colors.blue,
    }
    plugins.CmpItemKindMethod = {
        fg = colors.blue,
    }
    plugins.CmpItemKindKeyword = {
        fg = colors.purple,
    }
    plugins.CmpItemKindProperty = {
        fg = colors.red,
    }
    plugins.CmpItemKindUnit = {
        fg = colors.orange,
    }
    plugins.CmpItemKindClass = {
        fg = colors.yellow,
    }
    plugins.CmpItemKindModule = {
        fg = colors.yellow,
    }
    plugins.CmpItemKindConstructor = {
        fg = colors.blue,
    }
    plugins.CmpItemKindEnum = {
        fg = colors.yellow,
    }
    plugins.CmpItemKindEnumMember = {
        fg = colors.orange,
    }
    plugins.CmpItemKindEvent = {
        fg = colors.purple,
    }
    plugins.CmpItemKindOperator = {
        fg = colors.cyan,
    }
    plugins.CmpItemKindTypeParameter = {
        fg = colors.yellow,
    }
    plugins.CmpItemKindStruct = {
        fg = colors.yellow,
    }
    plugins.CmpItemKindField = {
        fg = colors.red,
    }
    plugins.CmpItemKindConstant = {
        fg = colors.orange,
    }
    plugins.CmpItemKindValue = {
        fg = colors.orange,
    }
    plugins.CmpItemKindSnippet = {
        fg = colors.green,
    }
    plugins.CmpItemKindFile = {
        fg = colors.fg0,
    }
    plugins.CmpItemKindFolder = {
        fg = colors.blue,
    }
    plugins.CmpItemKindColor = {
        fg = colors.cyan,
    }
    plugins.CmpItemKindReference = {
        fg = colors.cyan,
    }
    plugins.CmpItemMenu = {
        fg = colors.gray_light,
        italic = true,
    }

    -- which-key
    plugins.WhichKey = {
        fg = colors.purple,
        bold = true,
    }
    plugins.WhichKeyGroup = {
        fg = colors.blue,
    }
    plugins.WhichKeyDesc = {
        fg = colors.fg0,
    }
    plugins.WhichKeySeparator = {
        fg = colors.gray,
    }
    plugins.WhichKeyFloat = { link = 'NormalFloat' }
    plugins.WhichKeyBorder = { link = 'FloatBorder' }
    plugins.WhichKeyValue = {
        fg = colors.green,
    }

    return {
        syntax = syntax,
        editor = editor,
        vim = vimgroups,
        neovim = neovim,
        treesitter = treesitter,
        plugins = plugins,
    }
end

return M
