vim.pack.add({
	{src = "https://github.com/nvim-lualine/lualine.nvim"},
})

-- описываем один раз, используем в winbar и inactive_winbar
local filename = {
  "filename",
  path = 0,
  symbols = { modified = " ●", readonly = " 󰌾", unnamed = "[без имени]", newfile = "[новый]" },
  fmt = function(name)
    if vim.bo.filetype == "neo-tree" then return "neo-tree" end
    return name
  end,
}

require("lualine").setup({
  options = {
    theme = "auto",         -- цвета подстраиваются под твою схему из scheme.lua
    globalstatus = true,    -- один статуслайн на все окна, а не свой в каждом
    icons_enabled = true,   -- нужен Nerd Font
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },

  sections = {
    lualine_a = { { "mode", right_padding = 2 } },
    lualine_b = { "diff" },
    lualine_c = { "diagnostics" },
    lualine_x = {  "encoding" },
    lualine_y = {},
    lualine_z = { "location" },
  },

  inactive_sections = {
    lualine_a = {}, lualine_b = {}, lualine_c = {},
    lualine_x = { "filetype" },
    lualine_y = {}, lualine_z = {},
  },

  -- контекст файла — в шапке каждого окна
  winbar = {
    lualine_c = { filename },
    lualine_b = { "branch" },
  },

  inactive_winbar = {
    lualine_c = { filename },
    lualine_b = { "branch" },
  },

  -- корректный статуслайн в окнах плагинов, которые у тебя стоят
  extensions = { "neo-tree", "lazygit", "fzf", "mason", "quickfix" },
})

-- require("lualine").setup({})
