vim.g.copilot_no_tab_map = true
local map_array = require("utils.keymap").map_array

local COPILOT_ACTIONS = {
  { key = '<A-l>', fn = 'copilot#Accept("\\<CR>")', desc = 'Принять предложение от Copilot',      mode = 'i' },
  { key = '<A-]>', fn = 'copilot#Next()',           desc = 'Показать следующее предложение',      mode = 'i' },
  { key = '<A-[>', fn = 'copilot#Previous()',       desc = 'Показать предыдущее предложение',     mode = 'i' },
  { key = '<A-x>', fn = 'copilot#Dismiss()',        desc = 'Отклонить предложение от Copilot',    mode = 'i' },
}

map_array(COPILOT_ACTIONS, { expr = true, replace_keycodes = false })
