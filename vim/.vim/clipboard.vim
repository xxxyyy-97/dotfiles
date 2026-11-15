" ============================================================
"  ~/.vim/clipboard.vim — единый буфер обмена (Vim 8.0.1394+ / 9.x)
"  copy:  TextYankPost → провайдер (win32yank / OSC52 / wl-copy / xclip)
"  paste: <leader>p / <leader>P через регистр c
"  Маппинги живут здесь, а не в mappings.vim: зависят от провайдера.
" ============================================================

let s:copy  = ''     " команда: текст в stdin
let s:paste = ''     " команда: текст в stdout
let s:osc52 = 0
let s:reg   = 'c'    " регистр-приёмник
let s:wsl   = has('wsl') || exists('$WSL_DISTRO_NAME')

" ---------- 1. WSL → буфер Windows ----------
if s:wsl && executable('win32yank.exe')
  let s:copy  = 'win32yank.exe -i --crlf'
  let s:paste = 'win32yank.exe -o --lf'
elseif s:wsl && executable('clip.exe')
  let s:copy  = 'clip.exe'
  let s:paste = 'powershell.exe -NoProfile -Command Get-Clipboard | tr -d "\r"'

" ---------- 2. SSH → OSC 52 (только запись, как osc52_paste=false) ----------
elseif exists('$SSH_TTY') || exists('$SSH_CONNECTION')
  let s:osc52 = 1

" ---------- 3. macOS ----------
elseif has('mac') && executable('pbcopy')
  let s:copy  = 'pbcopy'
  let s:paste = 'pbpaste'

" ---------- 4. Wayland ----------
elseif exists('$WAYLAND_DISPLAY') && executable('wl-copy')
  let s:copy  = 'wl-copy'
  let s:paste = 'wl-paste --no-newline'

" ---------- 5. X11 нативно: Vim умеет сам ----------
elseif exists('$DISPLAY') && has('clipboard')
  set clipboard=unnamedplus
  nnoremap <silent> <leader>p :<C-u>normal! "+p<CR>
  nnoremap <silent> <leader>P :<C-u>normal! "+P<CR>
  finish

" ---------- 6. X11 через утилиты ----------
elseif exists('$DISPLAY') && executable('xclip')
  let s:copy  = 'xclip -selection clipboard -i'
  let s:paste = 'xclip -selection clipboard -o'
elseif exists('$DISPLAY') && executable('xsel')
  let s:copy  = 'xsel --clipboard --input'
  let s:paste = 'xsel --clipboard --output'
endif

" ---------- OSC 52 ----------
function! s:send_osc52(text) abort
  let l:b64 = system('base64 | tr -d "\n"', a:text)
  if v:shell_error | return | endif
  let l:seq = "\e]52;c;" . l:b64 . "\a"
  if exists('$TMUX')
    let l:seq = "\ePtmux;" . substitute(l:seq, "\e", "\e\e", 'g') . "\e\\"
  endif
  if filewritable('/dev/tty')
    call writefile([l:seq], '/dev/tty', 'b')
  endif
endfunction

" ---------- Копирование ----------
function! s:clip_copy(text) abort
  if a:text ==# '' | return | endif
  if s:osc52
    call s:send_osc52(a:text)
  elseif s:copy !=# ''
    if has('job') && has('channel')
      " асинхронно: win32yank.exe из WSL отвечает ~50-100 мс
      let l:job = job_start(['/bin/sh', '-c', s:copy],
            \ {'in_mode': 'raw', 'out_io': 'null', 'err_io': 'null'})
      let l:ch = job_getchannel(l:job)
      call ch_sendraw(l:ch, a:text)
      call ch_close_in(l:ch)
    else
      call system(s:copy, a:text)
    endif
  endif
endfunction

function! s:on_yank() abort
  " unnamedplus-семантика: только безымянный регистр, "ay буфер не трогает
  if v:event.regname !=# '' && v:event.regname !~# '[+*]'
    return
  endif
  if v:event.operator !=# 'y' && !get(g:, 'clipboard_sync_deletes', 0)
    return
  endif
  call s:clip_copy(getreg(v:event.regname ==# '' ? '"' : v:event.regname))
endfunction

if exists('##TextYankPost')
  augroup vim_clipboard
    autocmd!
    autocmd TextYankPost * call s:on_yank()
  augroup END
endif

" ---------- Вставка ----------
function! s:clip_load() abort
  if s:paste ==# '' | return 0 | endif
  let l:text = system(s:paste)
  if v:shell_error | return 0 | endif
  call setreg(s:reg, l:text, l:text =~# "\n$" ? 'V' : 'v')
  return 1
endfunction

function! s:clip_paste(cmd, visual) abort
  if !s:clip_load()
    " провайдера чтения нет (SSH/OSC52) — как paste_from_reg в nvim
    execute 'normal! ' . (a:visual ? 'gv' : '') . a:cmd
    return
  endif
  execute 'normal! ' . (a:visual ? 'gv' : '') . '"' . s:reg . a:cmd
endfunction

" ---------- Отдельный оператор: <leader>y ----------
" Копирует в системный буфер, НЕ трогая " (обычный y работает как раньше).
" Текст остаётся и в регистре c: "cp вручную, <C-r>c в insert-режиме.

function! s:clip_op(type, ...) abort
  let l:visual  = a:0 && a:1
  let l:unnamed = [getreg('"', 1, 1), getregtype('"')]
  let l:sel     = &selection
  set selection=inclusive
  try
    let l:l = l:visual ? "'<" : "'["
    let l:r = l:visual ? "'>" : "']"
    if a:type ==# 'line' || a:type ==# 'V'
      execute 'normal! ' . l:l . 'V' . l:r
    elseif a:type ==# 'block' || a:type ==# "\<C-v>"
      execute 'normal! ' . l:l . "\<C-v>" . l:r
    else
      execute 'normal! ' . l:l . 'v' . l:r
    endif
    " noautocmd: чтобы TextYankPost не отправил текст второй раз
    execute 'noautocmd normal! "' . s:reg . 'y'
  finally
    let &selection = l:sel
    call setreg('"', l:unnamed[0], l:unnamed[1])
  endtry

  let l:text = getreg(s:reg)
  if getregtype(s:reg) ==# 'V'
    let l:text .= "\n"
  endif
  call s:clip_copy(l:text)
  echo printf('clipboard ← %d chars%s', strchars(l:text),
        \ getregtype(s:reg) ==# 'V' ? ' (linewise)' : '')
endfunction

" строка/несколько строк: setreg не трогает " вообще, спасать нечего
" функция глобальная: <SID> в строке, возвращаемой <expr>-маппингом, не раскрывается
function! ClipYankLine(n) abort
  let l:last  = min([line('.') + a:n - 1, line('$')])
  let l:lines = getline(line('.'), l:last)
  call setreg(s:reg, l:lines, 'V')
  call s:clip_copy(join(l:lines, "\n") . "\n")
  echo 'clipboard ← ' . len(l:lines) . ' lines'
endfunction

nnoremap <silent> <leader>y  :<C-u>set opfunc=<SID>clip_op<CR>g@
xnoremap <silent> <leader>y  :<C-u>call <SID>clip_op(visualmode(), 1)<CR>
nnoremap <expr> <leader>yy ":\<C-u>call ClipYankLine(" . (v:count ? v:count : 1) . ")\<CR>"

nnoremap <silent> <leader>p :<C-u>call <SID>clip_paste('p', 0)<CR>
nnoremap <silent> <leader>P :<C-u>call <SID>clip_paste('P', 0)<CR>
xnoremap <silent> <leader>p :<C-u>call <SID>clip_paste('p', 1)<CR>

" явный доступ: :ClipLoad → потом <C-r>c в insert-режиме
command! ClipLoad call s:clip_load()
" скопировать диапазон/весь файл: :ClipCopy или :'<,'>ClipCopy
command! -range=% ClipCopy call s:clip_copy(join(getline(<line1>, <line2>), "\n") . "\n")
