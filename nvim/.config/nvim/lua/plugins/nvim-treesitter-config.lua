vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",

    -- Для классического require("nvim-treesitter.configs").
    -- Если у тебя новый main-branch nvim-treesitter и этот конфиг работает,
    -- можно попробовать убрать строку.
    branch = "master",

    -- Обновлять парсеры при обновлении плагина
    build = ":TSUpdate",

  },
})

require("nvim-treesitter").setup({
  highlight = {
    enable = true,
  },

  indent = {
    enable = true,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      node_decremental = "<C-backspace>",
      scope_incremental = "<CR>",
    },
  },
})
