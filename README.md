# Solstice

A carefully crafted dark color theme for Vim and Neovim with comprehensive
syntax highlighting, UI styling, and plugin integration.

## Features

- 🎨 **Harmonious Color Palette** - Carefully selected colors with proper
  contrast ratios for readability
- 🔄 **Dual Editor Support** - Works seamlessly in both Vim (8.2+) and Neovim
  (0.5+)
- 🌈 **True Color & 256-Color Support** - Adapts to your terminal's capabilities
- 🔌 **Plugin Integration** - Built-in support for popular plugins (LSP,
  Tree-sitter, Telescope, and more)
- ⚙️ **Highly Customizable** - Override colors, styles, and highlight groups to
  match your preferences
- 📦 **Zero Dependencies** - Pure Lua implementation with no external
  dependencies

## Color Palette

### Syntax Colors

| Color  | Hex       | Usage                          |
| ------ | --------- | ------------------------------ |
| Pink   | `#F095F7` | Keywords, errors, deletion     |
| Green  | `#BAEC7E` | Strings, additions             |
| Blue   | `#9ABBDD` | Functions, identifiers         |
| Yellow | `#e5c07b` | Constants, warnings            |
| Orange | `#d19a66` | Numbers, special               |
| Coral  | `#EA8675` | Types, classes, structs        |
| Cyan   | `#56b6c2` | Operators, special identifiers |

### Base Colors

| Color      | Hex       | Usage                     |
| ---------- | --------- | ------------------------- |
| Background | `#050505` | Main background           |
| Foreground | `#DADADA` | Main text, variable names |
| Gray       | `#E5E4B5` | Comments, subtle UI       |

## Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'yourusername/solstice',
  lazy = false,
  priority = 1000,
  config = function()
    require('solstice').setup({
      -- your configuration here (optional)
    })
    vim.cmd('colorscheme solstice')
  end,
}
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'yourusername/solstice',
  config = function()
    require('solstice').setup({
      -- your configuration here (optional)
    })
    vim.cmd('colorscheme solstice')
  end
}
```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'yourusername/solstice'

" In your init.vim or .vimrc
lua << EOF
require('solstice').setup({
  -- your configuration here (optional)
})
EOF

colorscheme solstice
```

### Manual Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/smartshader/solstice.git
   ```

2. Copy the files to your Vim/Neovim configuration directory:
   - **Neovim**: `~/.config/nvim/`
   - **Vim**: `~/.vim/`

3. Add to your configuration:
   ```lua
   require('solstice').setup()
   vim.cmd('colorscheme solstice')
   ```

## Configuration

Solstice comes with sensible defaults, but you can customize it to your liking:

```lua
require('solstice').setup({
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
    background = false,  -- Transparent background
    float = false,       -- Transparent floating windows
    statusline = false,  -- Transparent statusline
  },

  -- Terminal colors (set terminal colors when theme loads)
  terminal_colors = true,

  -- Plugin integrations (disable if you don't use these plugins)
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
  -- Override any palette color
  colors = {
    -- bg0 = '#000000',
    -- red = '#ff0000',
  },

  -- Custom highlight group overrides
  -- Override any highlight group
  overrides = {
    -- Comment = { fg = '#888888', italic = true },
    -- Function = { fg = '#61afef', bold = true },
  },
})
```

### Example Configurations

#### Minimal Setup

```lua
require('solstice').setup()
vim.cmd('colorscheme solstice')
```

#### Transparent Background

```lua
require('solstice').setup({
  transparent = {
    background = true,
    float = true,
  },
})
vim.cmd('colorscheme solstice')
```

#### Custom Styles

```lua
require('solstice').setup({
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
    functions = { bold = true },
  },
})
vim.cmd('colorscheme solstice')
```

#### Custom Colors

```lua
require('solstice').setup({
  colors = {
    red = '#ff6b6b',
    green = '#51cf66',
    blue = '#339af0',
  },
})
vim.cmd('colorscheme solstice')
```

## Supported Plugins

Solstice includes built-in support for the following popular plugins:

### LSP & Diagnostics

- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP diagnostics
  and references
- Native Neovim LSP UI elements

### Syntax & Highlighting

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) -
  Enhanced syntax highlighting

### File Navigation

- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy
  finder
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) - File explorer

### Git Integration

- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git decorations

### Completion

- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion menu

### UI Enhancements

- [which-key.nvim](https://github.com/folke/which-key.nvim) - Keybinding helper

## Requirements

### Neovim

- Neovim 0.5 or higher
- True color support recommended (set `termguicolors`)

### Vim

- Vim 8.2 or higher with `+lua` feature
- True color support recommended

### Compatibility Matrix

| Editor | Version | Lua Support | Theme Support    |
| ------ | ------- | ----------- | ---------------- |
| Neovim | 0.5+    | Native      | ✅ Full          |
| Vim    | 8.2+    | +lua        | ✅ Full          |
| Vim    | 8.2+    | No Lua      | ❌ Not supported |
| Vim    | < 8.2   | Any         | ❌ Not supported |
| Neovim | < 0.5   | Native      | ❌ Not supported |

### Terminal

For the best experience, use a terminal emulator that supports true colors
(24-bit):

- iTerm2 (macOS)
- Alacritty
- Kitty
- WezTerm
- Windows Terminal
- GNOME Terminal
- Konsole

Enable true colors in your configuration:

```lua
vim.opt.termguicolors = true
```

Or in Vimscript:

```vim
set termguicolors
```

## Troubleshooting

### Colors look wrong

1. Ensure your terminal supports true colors
2. Enable `termguicolors`:
   ```lua
   vim.opt.termguicolors = true
   ```
3. Check your `$TERM` environment variable (should be `xterm-256color` or
   similar)

### Theme not loading

1. Ensure Lua support is available:
   ```vim
   :echo has('lua')
   ```
   Should return `1`

2. Check for errors:
   ```vim
   :messages
   ```

### Plugin highlights not working

1. Ensure the plugin integration is enabled in your configuration
2. Load the theme after plugin setup
3. Try reloading the theme:
   ```vim
   :colorscheme solstice
   ```

## Contributing

Contributions are welcome! Here's how you can help:

### Reporting Issues

If you encounter any problems or have suggestions:

1. Check if the issue already exists in the
   [issue tracker](https://github.com/yourusername/solstice/issues)
2. If not, create a new issue with:
   - A clear description of the problem
   - Steps to reproduce
   - Your Vim/Neovim version (`:version`)
   - Your configuration
   - Screenshots if applicable

### Adding Plugin Support

To add support for a new plugin:

1. Fork the repository
2. Add highlight groups in `lua/solstice/highlights.lua`
3. Test the integration thoroughly
4. Submit a pull request with:
   - Description of the plugin
   - Screenshots showing the integration
   - Link to the plugin repository

### Improving Colors

If you have suggestions for color improvements:

1. Explain the reasoning (contrast, accessibility, aesthetics)
2. Provide before/after screenshots
3. Ensure changes maintain readability and contrast ratios

### Development Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/solstice.git
   cd solstice
   ```

2. Make your changes in the appropriate files:
   - `lua/solstice/palette.lua` - Color definitions
   - `lua/solstice/highlights.lua` - Highlight groups
   - `lua/solstice/config.lua` - Configuration options

3. Test your changes:
   ```vim
   :source %
   :colorscheme solstice
   ```

4. Submit a pull request with a clear description of your changes

### Code Style

- Use 4 spaces for indentation
- Follow existing code patterns
- Add comments for complex logic
- Keep functions focused and modular
- Validate all user inputs

## License

MIT License - see [LICENSE](LICENSE) file for details

## Acknowledgments

- Inspired by popular themes like One Dark, Gruvbox, and Nord
- Built with guidance from the Vim/Neovim community
- Color palette designed with accessibility in mind

## Related Projects

- [lualine-solstice](https://github.com/yourusername/lualine-solstice) -
  Solstice theme for lualine.nvim
- [tmux-solstice](https://github.com/yourusername/tmux-solstice) - Matching tmux
  theme

---

Made with ❤️ for the Vim/Neovim community
