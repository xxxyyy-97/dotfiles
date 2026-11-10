vim.pack.add({
        {src = "https://github.com/nvim-lualine/lualine.nvim"},
})
local function add_gui(base, extra)
 if not extra or extra == "" then return base or "" end
 local parts, seen = {}, {}
 for s in (base or ""):gmatch("[^,]+") do
   if not seen[s] then seen[s] = true; parts[#parts + 1] = s end
 end
 for s in extra:gmatch("[^,]+") do
   if not seen[s] then seen[s] = true; parts[#parts + 1] = s end
 end
 return table.concat(parts, ",")
end

local function theme_color(group, extra_gui)
 return function()
   local hl = vim.api.nvim_get_hl(0, { name = group, link = true })
   local gui = add_gui(hl["gui"], extra_gui)
   return {
     fg  = hl.fg and string.format("#%06x", hl.fg) or nil,
     bg  = hl.bg and string.format("#%06x", hl.bg) or nil,
     gui = gui ~= "" and gui or nil,
   }
 end
end

local ACTIVE_HL_GROUP = "Special"

-- Активное окно: зелёный String (#c3e88d) + bold + маркер ▎
local filename_active = {
 "filename",
 path = 0,
 color = theme_color(ACTIVE_HL_GROUP, "bold"),
 symbols = { modified = " ●", readonly = " 󰌾", unnamed = "[без имени]", newfile = "[новый]" },
 fmt = function(name)
   if vim.bo.filetype == "neo-tree" then return "▎ neo-tree" end
   return "▎ " .. name
 end,
}

-- Неактивные окна: тусклый Comment (#636da6), без bold, маркер = 2 пробела (ширина не прыгает)
local filename_inactive = {
 "filename",
 path = 0,
 color = "Comment",
 symbols = { modified = " ●", readonly = " 󰌾", unnamed = "[без имени]", newfile = "[новый]" },
 fmt = function(name)
   if vim.bo.filetype == "neo-tree" then return "  neo-tree" end
   return "  " .. name
 end,
 }
-- описываем один раз, используем в winbar и inactive_winbar
-- local filename = {
--   "filename",
--   path = 0,
--   symbols = { modified = " ●", readonly = " 󰌾", unnamed = "[без имени]", newfile = "[новый]" },
--   fmt = function(name)
--     if vim.bo.filetype == "neo-tree" then return "neo-tree" end
--     return name
--   end,
-- }

require("lualine").setup({
  options = {
    theme = "auto",         -- цвета подстраиваются под твою схему из scheme.lua
    globalstatus = true,    -- один статуслайн на все окна, а не свой в каждом
    icons_enabled = true,   -- нужен Nerd Font
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    always_divide_middle = false,  -- ← выключает растяжение левых секций
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
    lualine_c = { filename_active, "branch" },
    -- lualine_b = { "branch" },
  },

  inactive_winbar = {
    lualine_c = { filename_inactive, "branch" },
    -- lualine_b = { "branch" },
  },

  -- корректный статуслайн в окнах плагинов, которые у тебя стоят
  extensions = { "neo-tree", "fzf", "mason", "quickfix" },
})
