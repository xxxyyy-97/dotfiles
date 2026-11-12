--keymap для Copilot Chat

local map_array = require("utils.keymap").map_array

local COPILOT_CHAT_ACTIONS = {
  { key = '<leader>cc', fn = '<Cmd>CopilotChat<CR>',        desc = 'Открыть чат с Copilot'},
  { key = '<leader>ca', fn = '<Cmd>CopilotChatActAs<CR>',   desc = 'Задать роль для Copilot в чате'},
  { key = '<leader>cr', fn = '<Cmd>CopilotChatReset<CR>',   desc = 'Сбросить чат с Copilot'},
  { key = '<leader>cs', fn = '<Cmd>CopilotChatStatus<CR>',  desc = 'Показать статус чата с Copilot'},
  { key = '<leader>ct', fn = '<Cmd>CopilotChatToggle<CR>',  desc = 'Переключить чат с Copilot'},
}

map_array(COPILOT_CHAT_ACTIONS)
