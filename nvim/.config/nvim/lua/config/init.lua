--print("config init")

--vim.opts
vim.g.mapleader = " "
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

local o = vim.opt
o.showmode = false
-- o.timeoutlen = 170

-- Completion (используется встроенным vim.lsp.completion)
o.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }

-- o.chdir = false
-- o.autochdir = false

--все горизонтальные сплиты — внизу
o.splitbelow = true
--все вертикальные сплиты — справа
o.splitright = true

o.winborder = "rounded"

o.guicursor = "i:block"
o.relativenumber = true
o.nu = true
o.cursorline = true
--o.statuscolumn = [[ %= %{v:relnum ? v:relnum : v:lnum} ]]
--o.numberwidth = 5         -- ширина колонки с номерами
--o.signcolumn = "yes"    -- гарантированно резервирует 1 колонку для sign'ов

o.termguicolors = true --отображение цветов
--o.numberopt = "right"

o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true

o.encoding = "utf-8"
o.fileencoding = "utf-8"

require("config.clipboard")

o.winborder = "rounded"
o.list = false
o.listchars = 'tab:→ ,space:·,nbsp:☠,trail:•,eol:¶,precedes:«,extends:»'

--requires
--require("config.keymap")

--require("config.scheme")
