set background=dark
if has('termguicolors') && $COLORTERM =~# 'truecolor\|24bit'
  set termguicolors
endif
let g:tokyonight_style = 'night'
silent! colorscheme tokyonight
if get(g:, 'colors_name', '') !=# 'tokyonight'
  silent! colorscheme slate
endif
