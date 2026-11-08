vim.pack.add({
  "https://github.com/folke/snacks.nvim",
})

require("snacks").setup({
  bigfile = { enabled = true },      -- защита от зависания на больших файлах
  notifier = { enabled = true },     -- всплывающие уведомления
  dashboard = { enabled = false },   -- отключено (не мешает при запуске)
  picker = { enabled = false },      -- отключено (используете fzf-lua)
  image = { enabled = false },       -- отключено (убирает ошибки про magick/kitty)
  scroll = { enabled = true },      -- плавная прокрутка
  words = { enabled = true },
})
