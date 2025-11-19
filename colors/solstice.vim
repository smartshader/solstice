" Solstice colorscheme entry point

" Check if Lua is available
if !has('lua')
  echohl ErrorMsg
  echom 'Solstice colorscheme requires Lua support. Please use Vim 8.2+ with +lua or Neovim 0.5+.'
  echohl None
  finish
endif

" Check Vim version if not Neovim
if !has('nvim')
  if v:version < 802
    echohl ErrorMsg
    echom 'Solstice colorscheme requires Vim 8.2 or later. Current version: ' . v:version
    echohl None
    finish
  endif
endif

" Check Neovim version
if has('nvim')
  if !has('nvim-0.5')
    echohl ErrorMsg
    echom 'Solstice colorscheme requires Neovim 0.5 or later.'
    echohl None
    finish
  endif
endif

" Load the theme via Lua
lua << EOF
local ok, err = pcall(function()
  require('solstice.theme').load()
end)

if not ok then
  vim.api.nvim_err_writeln('Solstice colorscheme failed to load: ' .. tostring(err))
end
EOF
