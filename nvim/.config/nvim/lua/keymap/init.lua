vim.keymap.set("n", "<leader>e", "<Cmd>Explore<CR>")                                 -- менеджер netrw
vim.keymap.set("n", "<leader>r", "<Cmd>checktime<CR>")                                 -- обновить буфер
vim.keymap.set("n", "<esc>", "<Cmd>nohlsearch<CR>", { noremap = true, silent = true }) --убрать выделение
vim.keymap.set("n", "<C-q>", "<C-v>", { noremap = true, silent = true })             --переопределения для вхлда в режим v-block

vim.keymap.set({'n','i','v'}, '<Leader>c', function()
  vim.opt.list = not vim.o.list
  -- vim.opt.list = not vim.opt.list:get()
end, { desc = 'Toggle listchars' })

-- навигация между буферами
vim.keymap.set("n", "<leader>bl", "<Cmd>bnext<CR>", { noremap = true, silent = true, desc = "Следующий буфер" })
vim.keymap.set("n", "<leader>bh", "<Cmd>bprevious<CR>", { noremap = true, silent = true, desc = "Предыдущий буфер" })

vim.keymap.set("n", "<leader>bd", "<Cmd>bdelete#<CR>", { noremap = true, silent = true, desc = "Закрыть буфер" })
vim.keymap.set("n", "<leader>bx", "<Cmd>bdelete!<CR>", { noremap = true, silent = true, desc = "наорать и Закрыть буфер" })
vim.keymap.set("n", "<leader>bc", "<Cmd>enew<CR><Cmd>bdelete#<CR>",
  { noremap = true, silent = true, desc = "Закрыть текущий буфер, не закрывая окно" })
  --TODO 

-- навигация между вкладками (табами
vim.keymap.set("n", "<leader>tn", "<Cmd>tabnew<CR>", { noremap = true, silent = true, desc = "Новая вкладка" })
vim.keymap.set("n", "<leader>tx", "<Cmd>tabclose!<CR>", { noremap = true, silent = true, desc = "Закрыть текущую вкладку" })
vim.keymap.set("n", "<leader>tl", "<Cmd>tabnext<CR>", { noremap = true, silent = true, desc = "Следующая вкладка" })
vim.keymap.set("n", "<leader>th", "<Cmd>tabprevious<CR>", { noremap = true, silent = true, desc = "Предыдущая вкладка" })
vim.keymap.set("n", "<leader>to", "<Cmd>tabonly<CR>",
  { noremap = true, silent = true, desc = "Закрыть все вкладки, кроме текущей" })
vim.keymap.set("n", "<leader>tm", "<Cmd>tabmove<CR>",
  { noremap = true, silent = true, desc = "Переместить текущую вкладку" })
vim.keymap.set("n", "<leader>1", "<Cmd>tabfirst<CR>", { noremap = true, silent = true, desc = "Перейти к первой вкладке" })
vim.keymap.set("n", "<leader>2", "<Cmd>tabnext 2<CR>",
  { noremap = true, silent = true, desc = "Перейти ко второй вкладке" })
vim.keymap.set("n", "<leader>3", "<Cmd>tabnext 3<CR>",
  { noremap = true, silent = true, desc = "Перейти к третьей вкладке" })
vim.keymap.set("n", "<leader>4", "<Cmd>tabnext 4<CR>",
  { noremap = true, silent = true, desc = "Перейти к четвертой вкладке" })



-- терминал
vim.keymap.set("n", "<leader>tt", "<Cmd>tabnew | terminal<CR>", { noremap = true, silent = true, desc = "Новая вкладка с терминалом" })
vim.keymap.set("t", "jj", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Выход из терминала" })
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Выход из терминала" })

-- разделение окна
vim.keymap.set("n", "<leader>sT", "<Cmd>split | terminal<CR>", { noremap = true, silent = true, desc = "Открыть терминал в нижнем сплит-окне" })
vim.keymap.set("n", "<leader>st", "<Cmd>vsplit | terminal<CR>", { noremap = true, silent = true, desc = "Открыть терминал в нижнем сплит-окне" })
vim.keymap.set("n", "<leader>sv", "<Cmd>vsplit<CR>", { noremap = true, silent = true, desc = "Вертикальное разделение" })
vim.keymap.set("n", "<leader>sg", "<Cmd>split<CR>", { noremap = true, silent = true, desc = "Горизонтальное разделение" })
vim.keymap.set("n", "<leader>sx", "<Cmd>close!<CR>", { noremap = true, silent = true, desc = "Закрыть текущее окно" })
vim.keymap.set("n", "<leader>so", "<Cmd>only<CR>", { noremap = true, silent = true, desc = "Закрыть все окна, кроме текущего" })

-- навигация между окнами
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Переместиться в окно слева" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Переместиться в окно снизу" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Переместиться в окно сверху" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Переместиться в окно справа" })

-- Изменения размера окна
vim.keymap.set('n', '<C-Up>',    '<C-w>+', { desc = "Increase window height" })
vim.keymap.set('n', '<C-Down>',  '<C-w>-', { desc = "Decrease window height" })
vim.keymap.set('n', '<C-Left>',  '<C-w><', { desc = "Increase window width" })
vim.keymap.set('n', '<C-Right>', '<C-w>>', { desc = "Decrease window width" })
-- перемещение строк
vim.keymap.set("n", "<A-j>", "<Cmd>m .+1<CR>==", { noremap = true, silent = true, desc = "Переместить строку вниз" })
vim.keymap.set("n", "<A-k>", "<Cmd>m .-2<CR>==", { noremap = true, silent = true, desc = "Переместить строку вверх" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv",
  { noremap = true, silent = true, desc = "Переместить выделенные строки вниз" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv",
  { noremap = true, silent = true, desc = "Переместить выделенные строки вверх" })

--Отступы
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true, desc = "Уменьшить отступ" })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true, desc = "Увеличить отступ" })

vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true }) --быстрый выход из режима вставки
