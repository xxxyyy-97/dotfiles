--print("config init")

--vim.opts
vim.g.mapleader = " "

local o = vim.opt
o.showmode = false

-- o.chdir = false
o.autochdir = true

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

if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = 'win32yank',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf --selection=mouse',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf --selection=mouse',
    },
    cache_enabled = 0,
  }
end

o.winborder = "rounded"
o.clipboard = "unnamedplus"
o.list = false
o.listchars = 'tab:→ ,space:·,nbsp:☠,trail:•,eol:¶,precedes:«,extends:»'

--requires
--require("config.keymap")

--require("config.scheme")
