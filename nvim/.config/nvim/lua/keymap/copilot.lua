vim.g.copilot_no_tab_map = true

vim.keymap.set('i', '<A-l>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
  desc = "Принять предложение от Copilot",
})

vim.keymap.set('i', '<A-]>', 'copilot#Next()', {
  expr = true,
  replace_keycodes = false,
  desc = "Показать следующее предложение от Copilot",
})

vim.keymap.set('i', '<A-[>', 'copilot#Previous()', {
  expr = true,
  replace_keycodes = false,
  desc = "Показать предыдущее предложение от Copilot",
})
vim.keymap.set('i', '<A-x>', 'copilot#Dismiss()', {
  expr = true,
  replace_keycodes = false,
  desc = "Отклонить предложение от Copilot",
})
