" ============================================================
"  ~/.vim/mappings.vim
"  leader = <Space> задаётся в .vimrc ДО source этого файла.
"  ВАЖНО: у :map-команд хвостовых комментариев не бывает —
"  всё после rhs уходит в маппинг. Комментарии — отдельной строкой.
"  Посмотреть группы: :map <leader>b   :map <leader>t   :map <leader>s
" ============================================================

" ---------- Буферы ----------
" bl/bh — следующий/предыдущий; bd — удалить альтернативный (#);
" bx — удалить текущий без сохранения; bc — закрыть текущий, окно оставить
nnoremap <silent> <leader>bl :<C-u>bnext<CR>
nnoremap <silent> <leader>bh :<C-u>bprevious<CR>
nnoremap <silent> <leader>bd :<C-u>bdelete #<CR>
nnoremap <silent> <leader>bx :<C-u>bdelete!<CR>
nnoremap <silent> <leader>bc :<C-u>enew<CR>:bdelete #<CR>

" ---------- Вкладки ----------
" tn — новая; tx — закрыть; tl/th — след/пред; to — оставить только эту;
" tm — переместить в конец (:tabmove 0 — в начало)
nnoremap <silent> <leader>tn :<C-u>tabnew<CR>
nnoremap <silent> <leader>tx :<C-u>tabclose!<CR>
nnoremap <silent> <leader>tl :<C-u>tabnext<CR>
nnoremap <silent> <leader>th :<C-u>tabprevious<CR>
nnoremap <silent> <leader>to :<C-u>tabonly<CR>
nnoremap <silent> <leader>tm :<C-u>tabmove<CR>
nnoremap <silent> <leader>1  :<C-u>tabfirst<CR>
nnoremap <silent> <leader>2  :<C-u>tabnext 2<CR>
nnoremap <silent> <leader>3  :<C-u>tabnext 3<CR>
nnoremap <silent> <leader>4  :<C-u>tabnext 4<CR>

" ---------- Разделение окна ----------
" sv — вертикально; sg — горизонтально; sx — закрыть окно; so — только это окно
nnoremap <silent> <leader>sv :<C-u>vsplit<CR>
nnoremap <silent> <leader>sg :<C-u>split<CR>
nnoremap <silent> <leader>sx :<C-u>close!<CR>
nnoremap <silent> <leader>so :<C-u>only<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ---------- Терминал ----------
if has('terminal')
  " Vim делит окно сам, поэтому вместо 'split | terminal' — модификаторы.
  " tt — таб с терминалом; sT — снизу; st — справа
  nnoremap <silent> <leader>tt :<C-u>tab terminal<CR>
  nnoremap <silent> <leader>sT :<C-u>belowright terminal<CR>
  nnoremap <silent> <leader>st :<C-u>botright vertical terminal<CR>

  " выход в Terminal-Normal mode (аналог <C-\><C-n>); обратно — i / a
  tnoremap jj <C-w>N
  tnoremap <Esc> <C-w>N

  " опционально: навигация по окнам прямо из терминала
  " (учти: <C-h> в шелле — это backspace)
  " tnoremap <C-j> <C-w>j
  " tnoremap <C-k> <C-w>k
else
  " сборка без +terminal: хотя бы :shell, выход — exit / Ctrl-D
  nnoremap <silent> <leader>tt :<C-u>shell<CR>
endif

" ---------- Прочее (из .vimrc) ----------
" w — записать; q — выйти; h — сбросить подсветку поиска;
" l — невидимки; n — relativenumber; F2 — paste; f — :find; e — netrw
nnoremap <silent> <leader>w :<C-u>write<CR>
nnoremap <silent> <leader>q :<C-u>quit<CR>
nnoremap <silent> <leader>h :<C-u>nohlsearch<CR>
nnoremap <silent> <leader>l :<C-u>set list!<CR>
nnoremap <silent> <leader>n :<C-u>set relativenumber!<CR>
nnoremap <silent> <F2>      :<C-u>set paste!<CR>
nnoremap <leader>f :find <Space>
nnoremap <silent> <leader>e :<C-u>Lexplore 30<CR>

nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
nnoremap Y y$
vnoremap < <gv
vnoremap > >gv

" забыл sudo vim — сохраняем через sudo tee
cnoremap w!! w !sudo tee > /dev/null %
