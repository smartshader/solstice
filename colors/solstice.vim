" Solstice colorscheme entry point

" Check Neovim version (Neovim has native Lua support)
if has('nvim')
  if !has('nvim-0.5')
    echohl ErrorMsg
    echom 'Solstice colorscheme requires Neovim 0.5 or later.'
    echohl None
    finish
  endif
" Check Vim version and Lua support
elseif has('vim')
  if v:version < 802
    echohl ErrorMsg
    echom 'Solstice colorscheme requires Vim 8.2 or later. Current version: ' . v:version
    echohl None
    finish
  endif
  if !has('lua')
    echohl ErrorMsg
    echom 'Solstice colorscheme requires Lua support. Please compile Vim with +lua feature.'
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
