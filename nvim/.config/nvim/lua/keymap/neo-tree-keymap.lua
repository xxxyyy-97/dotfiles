local map_array = require("utils.keymap").map_array

-- одна обёртка вместо повторения ':Neotree ...<CR>'
local function neotree(args)
  return function() vim.cmd("Neotree " .. (args or "")) end
end

local NEO_TREE_ACTIONS = {
  -- === Базовые команды ===
  { key = '<leader>nn', fn = neotree('toggle'), desc = 'Переключить видимость' },
  { key = '<leader>nf', fn = neotree('focus'),  desc = 'Перевести фокус на окно' },
  { key = '<leader>nh', fn = neotree('reveal'), desc = 'Найти текущий файл в дереве' },

  -- === Позиции открытия ===
  { key = '<leader>no', fn = neotree(),                  desc = 'Открыть слева (по умолчанию)' },
  { key = '<leader>nO', fn = neotree('float'),           desc = 'Плавающее окно по центру' },
  { key = '<leader>nv', fn = neotree('position=right'),  desc = 'Вертикальный сплит справа' },
  { key = '<leader>nV', fn = neotree('position=left'),   desc = 'Вертикальный сплит слева' },
  { key = '<leader>ns', fn = neotree('position=bottom'), desc = 'Горизонтальный сплит снизу' },
  { key = '<leader>nS', fn = neotree('position=top'),    desc = 'Горизонтальный сплит сверху' },
  { key = '<leader>nt', fn = neotree('tab'),             desc = 'Открыть в новой вкладке' },
  { key = '<leader>nT', fn = neotree('current'),         desc = 'В текущем окне (заменяет редактор)' },

  -- === Источники ===
  { key = '<leader>nb', fn = neotree('buffers'),          desc = 'Список буферов' },
  { key = '<leader>nB', fn = neotree('buffers float'),    desc = 'Буферы в плавающем окне' },
  { key = '<leader>ng', fn = neotree('git_status'),       desc = 'Git-статус' },
  { key = '<leader>nG', fn = neotree('git_status float'), desc = 'Git-статус в плавающем окне' },
}

map_array(NEO_TREE_ACTIONS, { desc_prefix = 'Neo-tree: ' })
