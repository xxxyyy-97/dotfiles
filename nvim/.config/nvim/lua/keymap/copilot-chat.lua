--keymap для Copilot Chat
vim.keymap.set('n', '<leader>cc', '<Cmd>CopilotChat<CR>', {
  noremap = true,
  silent = true,
  desc = "Открыть чат с Copilot",
})

vim.keymap.set('n', '<leader>ca', '<Cmd>CopilotChatActAs<CR>', {
  noremap = true,
  silent = true,
  desc = "Задать роль для Copilot в чате",
})

vim.keymap.set('n', '<leader>cr', '<Cmd>CopilotChatReset<CR>', {
  noremap = true,
  silent = true,
  desc = "Сбросить чат с Copilot",
})

vim.keymap.set('n', '<leader>cs', '<Cmd>CopilotChatStatus<CR>', {
  noremap = true,
  silent = true,
  desc = "Показать статус чата с Copilot",
})

--CopilotChatToggle
vim.keymap.set('n', '<leader>ct', '<Cmd>CopilotChatToggle<CR>', {
  noremap = true,
  silent = true,
  desc = "Переключить чат с Copilot",
})

