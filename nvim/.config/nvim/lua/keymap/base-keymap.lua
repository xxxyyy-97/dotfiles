local map_array = require("utils.keymap").map_array

local BASE_ACTIONS = {
  { key = '<Leader>e',  fn ='<Cmd>Explore<CR>',     desc = 'менеджер netrw'},
  { key = '<Leader>r',  fn ='<Cmd>checktime<CR>',   desc = 'обновить буфер'},
  { key = '<esc>',      fn ='<Cmd>nohlsearch<CR>',  desc = 'убрать выделение'},
  { key = '<C-q>',      fn ='<C-v>',                desc = 'переопределения для вхлда в режим v-block'},

  -- навигация между буферами
  { key = '<leader>bl', fn ='<Cmd>bnext<CR>',               desc = 'Следующий буфер' },
  { key = '<leader>bh', fn ='<Cmd>bprevious<CR>',           desc = 'Предыдущий буфер' },
  { key = '<leader>bd', fn ='<Cmd>bdelete#<CR>',            desc = 'Закрыть буфер' },
  { key = '<leader>bx', fn ='<Cmd>bdelete!<CR>',            desc = 'наорать и Закрыть буфер' },
  { key = '<leader>bc', fn ='<Cmd>enew<CR><Cmd>bdelete#<CR>', desc = 'Закрыть текущий буфер, не закрывая окно' },

  -- навигация между вкладками (табами
  { key = '<leader>tn', fn ='<Cmd>tabnew<CR>',              desc = 'Новая вкладка' },
  { key = '<leader>tx', fn ='<Cmd>tabclose!<CR>',           desc = 'Закрыть текущую вкладку' },
  { key = '<leader>tl', fn ='<Cmd>tabnext<CR>',             desc = 'Следующая вкладка' },
  { key = '<leader>th', fn ='<Cmd>tabprevious<CR>',         desc = 'Предыдущая вкладка' },
  { key = '<leader>to', fn ='<Cmd>tabonly<CR>',             desc = 'Закрыть все вкладки, кроме текущей' },
  { key = '<leader>tm', fn ='<Cmd>tabmove<CR>',             desc = 'Переместить текущую вкладку' },
  { key = '<leader>1',  fn ='<Cmd>tabfirst<CR>',            desc = 'Перейти к первой вкладке' },
  { key = '<leader>2',  fn ='<Cmd>tabnext 2<CR>',           desc = 'Перейти ко второй вкладке' },
  { key = '<leader>3',  fn ='<Cmd>tabnext 3<CR>',           desc = 'Перейти к третьей вкладке' },
  { key = '<leader>4',  fn ='<Cmd>tabnext 4<CR>',           desc = 'Перейти к четвертой вкладке' },

  -- терминал
  { key = '<leader>tt', fn ='<Cmd>tabnew | terminal<CR>',   desc = 'Новая вкладка с терминалом' },
  { key = 'jj',         fn = '<C-\\><C-n>',                 desc = 'Выход из терминала',                  mode = 't' },
  { key = '<esc>',      fn = '<C-\\><C-n>',                 desc = 'Выход из терминала',                  mode = 't' },

  -- разделение окна
  { key = '<leader>sT', fn ='<Cmd>split | terminal<CR>',    desc = 'Открыть терминал в нижнем сплит-окне' },
  { key = '<leader>st', fn ='<Cmd>vsplit | terminal<CR>',   desc = 'Открыть терминал в правом сплит-окне' },
  { key = '<leader>sv', fn ='<Cmd>vsplit<CR>',              desc = 'Вертикальное разделение' },
  { key = '<leader>sg', fn ='<Cmd>split<CR>',               desc = 'Горизонтальное разделение' },
  { key = '<leader>sx', fn ='<Cmd>close!<CR>',              desc = 'Закрыть текущее окно' },
  { key = '<leader>so', fn ='<Cmd>only<CR>',                desc = 'Закрыть все окна, кроме текущего' },

  -- навигация между окнами
  { key = '<C-h>',      fn ='<C-w>h',                       desc = 'Переместиться в окно слева' },
  { key = '<C-j>',      fn ='<C-w>j',                       desc = 'Переместиться в окно снизу' },
  { key = '<C-k>',      fn ='<C-w>k',                       desc = 'Переместиться в окно сверху' },
  { key = '<C-l>',      fn ='<C-w>l',                       desc = 'Переместиться в окно справа' },

  -- Изменения размера окна
  { key = '<C-Up>',     fn = '<C-w>+',                      desc = 'Increase window height' },
  { key = '<C-Down>',   fn = '<C-w>-',                      desc = 'Decrease window height' },
  { key = '<C-Left>',   fn = '<C-w><',                      desc = 'Increase window width' },
  { key = '<C-Right>',  fn = '<C-w>>',                      desc = 'Decrease window width' },

  -- перемещение строк
  { key = '<A-j>',      fn ='m .+1<CR>==',                  desc = 'Переместить строку вниз' },
  { key = '<A-k>',      fn ='m .-2<CR>==',                  desc = 'Переместить строку вверх' },
  { key ='<A-j>',       fn = ":m '>+1<CR>gv=gv",            desc = 'Переместить выделенные строки вниз',  mode ='v'},
  { key ='<A-k>',       fn = ":m '<-2<CR>gv=gv",            desc = 'Переместить выделенные строки вверх', mode ='v' },

  --Отступы
  { key = '<',          fn = '<gv',                         desc = 'Уменьшить отступ',                    mode ='v' },
  { key = '>',          fn = '>gv',                         desc = 'Увеличить отступ',                    mode ='v' },
  { key = 'jj',         fn = '<Esc>',                       desc = 'быстрый выход из режима вставки',     mode ='i'},

  { key = '<Leader>c', fn = function() vim.opt.list = not vim.o.list end,   desc = 'Toggle listchars',  mode = {'n','v'}},
}

map_array(BASE_ACTIONS)
