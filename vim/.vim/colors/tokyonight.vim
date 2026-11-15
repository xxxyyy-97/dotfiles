" ============================================================
"  tokyonight.vim — Tokyo Night для Vim 9 (работает и в 8.2+)
"  ~/.vim/colors/tokyonight.vim
"  let g:tokyonight_style = 'night' | 'storm'
"  let g:tokyonight_italic = 0        " если курсив ломается в tmux
"  let g:tokyonight_transparent = 1   " фон терминала
" ============================================================

hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'tokyonight'
set background=dark

let s:style  = get(g:, 'tokyonight_style', 'night')
let s:italic = get(g:, 'tokyonight_italic', 1)
let s:it     = s:italic ? 'italic' : 'NONE'

" [ truecolor, xterm-256 ]
let s:c = {
      \ 'bg':       ['#1a1b26', 234],
      \ 'bg_dark':  ['#16161e', 233],
      \ 'bg_hl':    ['#292e42', 236],
      \ 'bg_vis':   ['#283457', 237],
      \ 'term_blk': ['#414868', 238],
      \ 'fg':       ['#c0caf5', 189],
      \ 'fg_dark':  ['#a9b1d6', 146],
      \ 'gutter':   ['#3b4261', 238],
      \ 'dark3':    ['#545c7e',  60],
      \ 'comment':  ['#565f89',  60],
      \ 'dark5':    ['#737aa2', 103],
      \ 'blue0':    ['#3d59a1',  61],
      \ 'blue':     ['#7aa2f7', 111],
      \ 'blue1':    ['#2ac3de',  44],
      \ 'blue2':    ['#0db9d7',  38],
      \ 'blue5':    ['#89ddff', 153],
      \ 'blue7':    ['#394b70',  60],
      \ 'cyan':     ['#7dcfff', 117],
      \ 'magenta':  ['#bb9af7', 141],
      \ 'purple':   ['#9d7cd8', 140],
      \ 'orange':   ['#ff9e64', 215],
      \ 'yellow':   ['#e0af68', 179],
      \ 'green':    ['#9ece6a', 149],
      \ 'green1':   ['#73daca',  79],
      \ 'teal':     ['#1abc9c',  37],
      \ 'red':      ['#f7768e', 204],
      \ 'red1':     ['#db4b4b', 167],
      \ 'diff_add': ['#20303b',  23],
      \ 'diff_del': ['#37222c',  52],
      \ 'diff_chg': ['#1f2231', 235],
      \ 'diff_txt': ['#394b70',  60],
      \ 'git_add':  ['#449dab',  73],
      \ 'git_chg':  ['#6183bb',  67],
      \ 'git_del':  ['#914c54', 131],
      \ 'none':     ['NONE', 'NONE'],
      \ }

if s:style ==# 'storm'
  let s:c.bg     = ['#24283b', 235]
  let s:c.bg_dark = ['#1f2335', 234]
  let s:c.bg_vis = ['#2e3c64', 238]
endif

function! s:hi(group, fg, bg, ...) abort
  let l:attr = a:0 ? a:1 : 'NONE'
  let l:ca = l:attr =~# 'undercurl' ? 'underline' : l:attr
  let l:cmd = 'hi ' . a:group
        \ . ' guifg=' . s:c[a:fg][0] . ' ctermfg=' . s:c[a:fg][1]
        \ . ' guibg=' . s:c[a:bg][0] . ' ctermbg=' . s:c[a:bg][1]
        \ . ' gui=' . l:attr . ' cterm=' . l:ca
  if a:0 > 1
    let l:cmd .= ' guisp=' . s:c[a:2][0]
  endif
  execute l:cmd
endfunction

" ---------- UI ----------
call s:hi('Normal',        'fg',       'bg')
call s:hi('NormalNC',      'fg_dark',  'bg')
call s:hi('Terminal',      'fg',       'bg')
call s:hi('Cursor',        'bg',       'fg')
call s:hi('lCursor',       'bg',       'fg')
call s:hi('CursorLine',    'none',     'bg_hl')
call s:hi('CursorColumn',  'none',     'bg_hl')
call s:hi('ColorColumn',   'none',     'bg_dark')
call s:hi('LineNr',        'gutter',   'bg')
call s:hi('CursorLineNr',  'orange',   'bg_hl',  'bold')
call s:hi('SignColumn',    'gutter',   'bg')
call s:hi('FoldColumn',    'comment',  'bg')
call s:hi('Folded',        'blue',     'gutter')
call s:hi('VertSplit',     'blue7',    'bg')
call s:hi('WinSeparator',  'blue7',    'bg')
call s:hi('Visual',        'none',     'bg_vis')
call s:hi('VisualNOS',     'none',     'bg_vis')
call s:hi('Search',        'fg',       'blue0')
call s:hi('IncSearch',     'bg',       'orange')
call s:hi('CurSearch',     'bg',       'orange')
call s:hi('Substitute',    'bg',       'red')
call s:hi('MatchParen',    'orange',   'bg_hl',  'bold')
call s:hi('Pmenu',         'fg',       'bg_dark')
call s:hi('PmenuSel',      'fg',       'bg_hl',  'bold')
call s:hi('PmenuSbar',     'none',     'bg_dark')
call s:hi('PmenuThumb',    'none',     'gutter')
call s:hi('PmenuMatch',    'blue1',    'bg_dark', 'bold')
call s:hi('WildMenu',      'bg',       'blue')
call s:hi('StatusLine',    'fg_dark',  'bg_dark')
call s:hi('StatusLineNC',  'comment',  'bg_dark')
call s:hi('TabLine',       'gutter',   'bg_dark')
call s:hi('TabLineFill',   'none',     'bg_dark')
call s:hi('TabLineSel',    'bg',       'blue',   'bold')
call s:hi('ModeMsg',       'fg_dark',  'none',   'bold')
call s:hi('MoreMsg',       'blue',     'none')
call s:hi('WarningMsg',    'yellow',   'none')
call s:hi('ErrorMsg',      'red1',     'none',   'bold')
call s:hi('Question',      'blue',     'none')
call s:hi('Title',         'blue',     'none',   'bold')
call s:hi('Directory',     'blue',     'none')
call s:hi('NonText',       'dark3',    'none')
call s:hi('SpecialKey',    'dark3',    'none')
call s:hi('Whitespace',    'gutter',   'none')
call s:hi('EndOfBuffer',   'bg',       'bg')
call s:hi('Conceal',       'dark5',    'none')
call s:hi('QuickFixLine',  'none',     'bg_vis', 'bold')
call s:hi('qfLineNr',      'dark5',    'none')
call s:hi('qfFileName',    'blue',     'none')

" блок режима в нашем статуслайне (%1*) — тема его определяет сама,
" чтобы не слетал после :colorscheme
call s:hi('User1', 'bg',      'blue',   'bold')
call s:hi('User2', 'fg_dark', 'bg_hl')
call s:hi('User3', 'red',     'bg_dark', 'bold')

" ---------- Diff / spell ----------
call s:hi('DiffAdd',      'none',    'diff_add')
call s:hi('DiffChange',   'none',    'diff_chg')
call s:hi('DiffDelete',   'none',    'diff_del')
call s:hi('DiffText',     'none',    'diff_txt')
call s:hi('diffAdded',    'git_add', 'none')
call s:hi('diffRemoved',  'git_del', 'none')
call s:hi('diffChanged',  'git_chg', 'none')
call s:hi('diffFile',     'blue',    'none')
call s:hi('diffLine',     'comment', 'none')
call s:hi('SpellBad',   'none', 'none', 'undercurl', 'red1')
call s:hi('SpellCap',   'none', 'none', 'undercurl', 'yellow')
call s:hi('SpellLocal', 'none', 'none', 'undercurl', 'blue1')
call s:hi('SpellRare',  'none', 'none', 'undercurl', 'magenta')

" ---------- Синтаксис ----------
call s:hi('Comment',        'comment', 'none', s:it)
call s:hi('Constant',       'orange',  'none')
call s:hi('String',         'green',   'none')
call s:hi('Character',      'green',   'none')
call s:hi('Number',         'orange',  'none')
call s:hi('Boolean',        'orange',  'none')
call s:hi('Float',          'orange',  'none')
call s:hi('Identifier',     'magenta', 'none')
call s:hi('Function',       'blue',    'none')
call s:hi('Statement',      'magenta', 'none')
call s:hi('Conditional',    'magenta', 'none')
call s:hi('Repeat',         'magenta', 'none')
call s:hi('Label',          'magenta', 'none')
call s:hi('Operator',       'blue5',   'none')
call s:hi('Keyword',        'cyan',    'none', s:it)
call s:hi('Exception',      'magenta', 'none')
call s:hi('PreProc',        'cyan',    'none')
call s:hi('Include',        'cyan',    'none')
call s:hi('Define',         'cyan',    'none')
call s:hi('Macro',          'cyan',    'none')
call s:hi('PreCondit',      'cyan',    'none')
call s:hi('Type',           'blue1',   'none')
call s:hi('StorageClass',   'blue1',   'none')
call s:hi('Structure',      'blue1',   'none')
call s:hi('Typedef',        'blue1',   'none')
call s:hi('Special',        'blue1',   'none')
call s:hi('SpecialChar',    'blue1',   'none')
call s:hi('Tag',            'blue',    'none')
call s:hi('Delimiter',      'fg_dark', 'none')
call s:hi('SpecialComment', 'comment', 'none', s:it)
call s:hi('Debug',          'orange',  'none')
call s:hi('Underlined',     'blue',    'none', 'underline')
call s:hi('Ignore',         'bg',      'none')
call s:hi('Error',          'red1',    'none', 'bold')
call s:hi('Todo',           'bg',      'yellow', 'bold')

" ---------- netrw ----------
call s:hi('netrwDir',      'blue',    'none')
call s:hi('netrwClassify', 'blue5',   'none')
call s:hi('netrwLink',     'comment', 'none')
call s:hi('netrwSymLink',  'cyan',    'none')
call s:hi('netrwExe',      'green',   'none')
call s:hi('netrwComment',  'comment', 'none')
call s:hi('netrwList',     'blue1',   'none')
call s:hi('netrwHelpCmd',  'cyan',    'none')
call s:hi('netrwCmdSep',   'dark3',   'none')
call s:hi('netrwTreeBar',  'gutter',  'none')
call s:hi('netrwMarkFile', 'bg',      'blue')

" ---------- ANSI для :terminal ----------
let g:terminal_ansi_colors = [
      \ s:c.term_blk[0], s:c.red[0],   s:c.green[0], s:c.yellow[0],
      \ s:c.blue[0],     s:c.magenta[0], s:c.cyan[0], s:c.fg_dark[0],
      \ s:c.comment[0],  s:c.red[0],   s:c.green[0], s:c.yellow[0],
      \ s:c.blue[0],     s:c.magenta[0], s:c.cyan[0], s:c.fg[0],
      \ ]

if get(g:, 'tokyonight_transparent', 0)
  hi Normal guibg=NONE ctermbg=NONE
  hi NormalNC guibg=NONE ctermbg=NONE
  hi LineNr guibg=NONE ctermbg=NONE
  hi SignColumn guibg=NONE ctermbg=NONE
  hi EndOfBuffer guibg=NONE ctermbg=NONE
endif
