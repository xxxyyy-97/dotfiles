vim.pack.add({
  "https://github.com/s1n7ax/nvim-window-picker",
})

-- 2. Настройка плагина
require('window-picker').setup({
  hint = "floating-big-letter", -- Стиль: большие буквы поверх окон
  show_prompt = false,          -- Не показывать строку "Pick window:" внизу
  filter_rules = {
    include_current_win = true, -- Разрешить выбор текущего окна
    autoselect_one = true,      -- Если доступно только одно окно, выбрать его сразу
    -- Исключить служебные окна из выбора, чтобы не сломать их случайно
    bo = {
      filetype = { "neo-tree", "neo-tree-popup", "notify", "qf", "help" },
      buftype = { "terminal", "quickfix", "prompt" },
    },
  },
})
