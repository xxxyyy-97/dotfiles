-- Переключение на предыдущее окно (удобно для прыжка neo-tree ↔ редактор)
vim.keymap.set('n', '<leader>w', '<C-w>p', { desc = "Переключиться на предыдущее окно (например, neo-tree ↔ редактор)" })

-- === Базовые команды ===
vim.keymap.set('n', '<leader>nn', ':Neotree toggle<CR>', { noremap = true, silent = true, desc = "Переключить видимость Neo-tree" })
vim.keymap.set('n', '<leader>nf', ':Neotree focus<CR>', { noremap = true, silent = true, desc = "Перевести фокус на окно Neo-tree" })
vim.keymap.set('n', '<leader>nh', ':Neotree reveal<CR>', { noremap = true, silent = true, desc = "Найти текущий файл в Neo-tree" })

-- === Разные позиции открытия ===
vim.keymap.set('n', '<leader>no', ':Neotree<CR>', { noremap = true, silent = true, desc = "Открыть Neo-tree слева (по умолчанию)" })
vim.keymap.set('n', '<leader>nO', ':Neotree float<CR>', { noremap = true, silent = true, desc = "Открыть Neo-tree в плавающем окне по центру" })
vim.keymap.set('n', '<leader>nv', ':Neotree position=right<CR>', { noremap = true, silent = true, desc = "Открыть Neo-tree в вертикальном сплите справа" })
vim.keymap.set('n', '<leader>nV', ':Neotree position=left<CR>', { noremap = true, silent = true, desc = "Открыть Neo-tree в вертикальном сплите слева" })
vim.keymap.set('n', '<leader>ns', ':Neotree position=bottom<CR>', { noremap = true, silent = true, desc = "Открыть Neo-tree в горизонтальном сплите снизу" })
vim.keymap.set('n', '<leader>nS', ':Neotree position=top<CR>', { noremap = true, silent = true, desc = "Открыть Neo-tree в горизонтальном сплите сверху" })
vim.keymap.set('n', '<leader>nt', ':Neotree tab<CR>', { noremap = true, silent = true, desc = "Открыть Neo-tree в новой вкладке" })
vim.keymap.set('n', '<leader>nT', ':Neotree current<CR>', { noremap = true, silent = true, desc = "Открыть Neo-tree в текущем окне (заменяет редактор)" })

-- === Разные источники ===
vim.keymap.set('n', '<leader>nb', ':Neotree buffers<CR>', { noremap = true, silent = true, desc = "Открыть список буферов в Neo-tree" })
vim.keymap.set('n', '<leader>nB', ':Neotree buffers float<CR>', { noremap = true, silent = true, desc = "Открыть список буферов в плавающем окне" })
vim.keymap.set('n', '<leader>ng', ':Neotree git_status<CR>', { noremap = true, silent = true, desc = "Открыть Git-статус в Neo-tree" })
vim.keymap.set('n', '<leader>nG', ':Neotree git_status float<CR>', { noremap = true, silent = true, desc = "Открыть Git-статус в плавающем окне" })
