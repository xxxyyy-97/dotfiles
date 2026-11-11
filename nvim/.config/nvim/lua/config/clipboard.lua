-- Единая настройка буфера обмена для всех машин.
-- Подключается из lua/config/init.lua строкой: require("config.clipboard")

-- false — вставка из внутреннего регистра nvim (нужно для Windows Terminal,
--         он запрещает терминальным программам читать буфер обмена)
-- true  — честная вставка через OSC 52 (kitty, WezTerm и т.п.)
local osc52_paste = false

local function clipboard_enable()
  vim.opt.clipboard = "unnamedplus"
end

-- 1. WSL: буфер Windows через win32yank
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "win32yank",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf --selection=mouse",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf --selection=mouse",
    },
    cache_enabled = 0,
  }
  clipboard_enable()
  return
end

-- 2. SSH на сервер: буфер вашей локальной машины через OSC 52
if vim.env.SSH_TTY or vim.env.SSH_CONNECTION then
  local osc52 = require("vim.ui.clipboard.osc52")

  local function paste_from_reg()
    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
  end

  vim.g.clipboard = {
    name = "OSC 52 (SSH)",
    copy = {
      ["+"] = osc52.copy("+"),
      ["*"] = osc52.copy("*"),
    },
    paste = osc52_paste and {
      ["+"] = osc52.paste("+"),
      ["*"] = osc52.paste("*"),
    } or {
      ["+"] = paste_from_reg,
      ["*"] = paste_from_reg,
    },
  }
  clipboard_enable()
  return
end

-- 3. Нативные Windows / macOS: встроенные провайдеры Neovim, настройка не нужна
if vim.fn.has("win32") == 1 or vim.fn.has("mac") == 1 then
  clipboard_enable()
  return
end

-- 4. Linux с графикой: Wayland (wl-clipboard) или X11 (xclip/xsel) —
--    провайдер Neovim найдёт сам, главное включить unnamedplus
if (vim.env.WAYLAND_DISPLAY and vim.fn.executable("wl-copy") == 1)
  or (vim.env.DISPLAY and (vim.fn.executable("xclip") == 1 or vim.fn.executable("xsel") == 1))
then
  clipboard_enable()
  return
end

-- 5. Локальная TTY без графики: clipboard не трогаем,
--    копирование/вставка — средствами терминала
