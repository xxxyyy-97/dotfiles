" ============================================================
"  statusline.vim — статуслайн + winbar (если Vim умеет)
"    let g:have_nerd_font = 1   " глифы Nerd Font
"    let g:statusline_vcs = 1   " git branch + diff по файлу
" ============================================================

let s:nerd = get(g:, 'have_nerd_font', 0)
let s:vcs  = get(g:, 'statusline_vcs', 0) && executable('git')
let s:wb   = exists('+winbar')
let s:uni  = has('multi_byte') && &encoding =~? '^utf-\?8$'

" ---------- символы ----------
let s:mark = s:uni ? nr2char(0x258E) . ' ' : '| '
let s:mod  = s:uni ? ' ' . nr2char(0x25CF) : ' +'
let s:ro   = s:nerd ? ' ' . nr2char(0xF023) : ' [RO]'
let s:sepl = s:nerd ? nr2char(0xE0B0) : (s:uni ? nr2char(0x258C) : '|')
let s:sepr = s:nerd ? nr2char(0xE0B2) : (s:uni ? nr2char(0x2590) : '|')
let s:csep = s:nerd ? nr2char(0xE0B1) : (s:uni ? nr2char(0x2502) : '|')
let s:br   = s:nerd ? nr2char(0xE0A0) . ' ' : ''

" ---------- режимы: id и группа-донор цвета из темы ----------
let s:mode_id = {
      \ 'n': 'Normal', 'no': 'Op', 'i': 'Insert', 'R': 'Replace',
      \ 'v': 'Visual', 'V': 'Visual', "\<C-v>": 'Visual',
      \ 's': 'Visual', 'S': 'Visual', 'c': 'Command', 't': 'Terminal' }
let s:mode_src = {
      \ 'Normal':   'Function',
      \ 'Op':       'Constant',
      \ 'Insert':   'String',
      \ 'Replace':  'Error',
      \ 'Visual':   'Statement',
      \ 'Command':  'WarningMsg',
      \ 'Terminal': 'Special' }

" ---------- цвета ----------
function! s:none(v) abort
  return empty(a:v) ? 'NONE' : a:v
endfunction

function! s:derive(src, dst, attr) abort
  let l:id = synIDtrans(hlID(a:src))
  execute 'hi' a:dst
        \ 'guifg=' . s:none(synIDattr(l:id, 'fg', 'gui'))
        \ 'ctermfg=' . s:none(synIDattr(l:id, 'fg', 'cterm'))
        \ 'guibg=NONE ctermbg=NONE'
        \ 'gui=' . a:attr 'cterm=' . a:attr
endfunction

function! s:colors() abort
  call s:derive('Special', 'StFile',   'bold')
  call s:derive('Comment', 'StFileNC', 'NONE')

  let l:sl  = synIDtrans(hlID('StatusLine'))
  let l:bg  = s:none(synIDattr(l:sl, 'bg', 'gui'))
  let l:cbg = s:none(synIDattr(l:sl, 'bg', 'cterm'))

  for [l:id, l:src] in items(s:mode_src)
    let l:sid = synIDtrans(hlID(l:src))
    let l:fg  = s:none(synIDattr(l:sid, 'fg', 'gui'))
    let l:cfg = s:none(synIDattr(l:sid, 'fg', 'cterm'))
    execute 'hi StMode' . l:id
          \ 'guifg=' . l:bg 'ctermfg=' . l:cbg
          \ 'guibg=' . l:fg 'ctermbg=' . l:cfg
          \ 'gui=bold cterm=bold'
    execute 'hi StSep' . l:id
          \ 'guifg=' . l:fg 'ctermfg=' . l:cfg
          \ 'guibg=' . l:bg 'ctermbg=' . l:cbg
  endfor

  if s:wb
    hi default link WinBar   StatusLine
    hi default link WinBarNC StatusLineNC
  endif
endfunction

" ---------- компоненты ----------
let s:modes = {
      \ 'n': 'NORMAL', 'no': 'OP', 'i': 'INSERT', 'R': 'REPLACE',
      \ 'v': 'VISUAL', 'V': 'V-LINE', "\<C-v>": 'V-BLOCK',
      \ 's': 'SELECT', 'S': 'S-LINE', 'c': 'COMMAND', 't': 'TERMINAL' }

function! StMode() abort
  return get(s:modes, mode(), mode())
endfunction

function! StName(active) abort
  let l:mark = a:active ? s:mark : '  '
  if &filetype ==# 'netrw'
    return l:mark . 'netrw'
  endif
  let l:n = expand('%:t')
  if l:n ==# ''
    let l:n = '[без имени]'
  elseif &buftype ==# '' && !filereadable(expand('%:p'))
    let l:n = '[новый]'
  endif
  if &modified | let l:n .= s:mod | endif
  if &readonly | let l:n .= s:ro | endif
  return l:mark . l:n
endfunction

function! StEnc() abort
  return (&fileencoding !=# '' ? &fileencoding : &encoding) . ' ' . &fileformat
endfunction

function! StQf() abort
  let l:n = getqflist({'size': 1}).size
  return l:n ? 'QF ' . l:n . ' ' : ''
endfunction

function! StBranch() abort
  let l:b = get(b:, 'vcs_branch', '')
  return l:b ==# '' ? '' : ' ' . s:csep . ' ' . s:br . l:b
endfunction

function! StAdd() abort
  let l:n = get(b:, 'vcs_add', 0)
  return l:n ? ' +' . l:n : ''
endfunction

function! StDel() abort
  let l:n = get(b:, 'vcs_del', 0)
  return l:n ? ' -' . l:n : ''
endfunction

" ---------- git ----------
function! s:vcs_store(buf, lines) abort
  let l:add = 0
  let l:del = 0
  for l:l in a:lines[1:]
    let l:f = split(l:l, "\t")
    if len(l:f) >= 2
      let l:add += str2nr(l:f[0])
      let l:del += str2nr(l:f[1])
    endif
  endfor
  call setbufvar(a:buf, 'vcs_branch', get(a:lines, 0, ''))
  call setbufvar(a:buf, 'vcs_add', l:add)
  call setbufvar(a:buf, 'vcs_del', l:del)
endfunction

function! s:vcs_out(buf, ch, msg) abort
  call setbufvar(a:buf, 'vcs_raw', getbufvar(a:buf, 'vcs_raw', '') . a:msg . "\n")
endfunction

function! s:vcs_done(buf, job, code) abort
  call s:vcs_store(a:buf, split(getbufvar(a:buf, 'vcs_raw', ''), "\n"))
  call setbufvar(a:buf, 'vcs_raw', '')
  redraw
endfunction

function! s:vcs_refresh() abort
  if !s:vcs || &buftype !=# '' || expand('%') ==# ''
    return
  endif
  let l:git = finddir('.git', expand('%:p:h') . ';')
  if empty(l:git)
    let b:vcs_branch = ''
    let b:vcs_add = 0
    let b:vcs_del = 0
    return
  endif
  let l:cmd = 'cd ' . shellescape(fnamemodify(l:git, ':h'))
        \ . ' && git rev-parse --abbrev-ref HEAD && git diff --numstat -- '
        \ . shellescape(expand('%:p'))
  let l:buf = bufnr('%')
  call setbufvar(l:buf, 'vcs_raw', '')
  if has('job')
    call job_start(['/bin/sh', '-c', l:cmd], {
          \ 'out_mode': 'nl', 'err_io': 'null',
          \ 'out_cb': function('s:vcs_out', [l:buf]),
          \ 'exit_cb': function('s:vcs_done', [l:buf]) })
  else
    call s:vcs_store(l:buf, systemlist(l:cmd))
  endif
endfunction

" ---------- блоки ----------
function! s:mid() abort
  return get(s:mode_id, mode(), 'Normal')
endfunction

function! s:mode_block() abort
  return '%#StMode' . s:mid() . '# %{StMode()} %*'
endfunction

function! s:sep_l() abort
  return '%#StSep' . s:mid() . '#' . s:sepl . '%*'
endfunction

function! s:sep_r() abort
  return '%#StSepNormal#' . s:sepr . '%*'
endfunction

function! s:name_block(active) abort
  let l:g = a:active ? 'StFile' : 'StFileNC'
  return '%#' . l:g . '#%{StName(' . a:active . ')}%*'
endfunction

function! s:diff_block() abort
  return '%#diffAdded#%{StAdd()}%#diffRemoved#%{StDel()}%*'
endfunction

function! s:global_stl() abort
  return s:mode_block() . s:sep_l()
        \ . s:diff_block()
        \ . '%#WarningMsg#%{StQf()}%*'
        \ . '%=%{StEnc()} '
        \ . s:sep_r() . '%#StModeNormal# %l:%c %P %*'
endfunction

function! s:window_stl(active) abort
  if a:active
    return s:mode_block() . s:sep_l() . ' '
          \ . s:name_block(1)
          \ . '%#Comment#%{StBranch()}%*'
          \ . s:diff_block()
          \ . '%#WarningMsg#%{StQf()}%*'
          \ . '%=%{StEnc()} ' . s:sep_r() . '%#StModeNormal# %l:%c %P %*'
  endif
  return ' ' . s:name_block(0)
        \ . '%#Comment#%{StBranch()}%*'
        \ . '%=%{&filetype} %l:%c '
endfunction

function! s:winbar(active) abort
  return s:name_block(a:active) . '%#Comment#%{StBranch()}%*'
endfunction

function! s:apply(active) abort
  if &buftype =~# '^\(quickfix\|help\|terminal\|prompt\)$'
    if s:wb
      let &l:winbar = ''
    else
      let &l:statusline = ''
    endif
    return
  endif
  if s:wb
    let &l:winbar = s:winbar(a:active)
  else
    let &l:statusline = s:window_stl(a:active)
  endif
endfunction

" ---------- инициализация ----------
call s:colors()
set noshowmode
set noruler

if s:wb
  silent! set laststatus=3
  if &laststatus != 3
    set laststatus=2
  endif
  let &statusline = s:global_stl()
else
  set laststatus=2
  set statusline=
endif

call s:apply(1)

augroup vim_statusline
  autocmd!
  autocmd ColorScheme * call s:colors()
  autocmd VimEnter,WinEnter,BufWinEnter,BufEnter * call s:apply(1)
  autocmd WinLeave * call s:apply(0)
  autocmd BufEnter,BufWritePost,FocusGained * call s:vcs_refresh()
  if exists('##ModeChanged')
    autocmd ModeChanged * call s:apply(1) | redrawstatus
  endif
augroup END
