local map_array = require("utils.keymap").map_array

local BUFFERLINE_ACTIONS = {
  { key = '<A-1>', fn = '<Cmd>BufferLineGoToBuffer 1<CR>',  desc = 'Открыть буфер 1'},
  { key = '<A-2>', fn = '<Cmd>BufferLineGoToBuffer 2<CR>',  desc = 'Открыть буфер 2'},
  { key = '<A-3>', fn = '<Cmd>BufferLineGoToBuffer 3<CR>',  desc = 'Открыть буфер 3'},
  { key = '<A-4>', fn = '<Cmd>BufferLineGoToBuffer 4<CR>',  desc = 'Открыть буфер 4'},
  { key = '<A-5>', fn = '<Cmd>BufferLineGoToBuffer 5<CR>',  desc = 'Открыть буфер 5'},
  { key = '<A-6>', fn = '<Cmd>BufferLineGoToBuffer 6<CR>',  desc = 'Открыть буфер 6'},
  { key = '<A-7>', fn = '<Cmd>BufferLineGoToBuffer 7<CR>',  desc = 'Открыть буфер 7'},
  { key = '<A-8>', fn = '<Cmd>BufferLineGoToBuffer 8<CR>',  desc = 'Открыть буфер 8'},
  { key = '<A-9>', fn = '<Cmd>BufferLineGoToBuffer 9<CR>',  desc = 'Открыть буфер 9'},
  { key = '<A-p>', fn = '<Cmd>BufferLineCyclePrev<CR>',     desc = 'Открыть предыдущий буфер'},
  { key = '<A-n>', fn = '<Cmd>BufferLineCycleNext<CR>',     desc = 'Открыть следующий буфер'},
}

map_array(BUFFERLINE_ACTIONS)
