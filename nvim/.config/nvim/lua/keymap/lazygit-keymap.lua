local map_array = require("utils.keymap").map_array

local LAZYGIT_ACTIONS = {
  { key = '<leader>lg', fn = ':LazyGit<CR>',                desc = 'LazyGit: запуск LazyGit'},
  { key = '<leader>lG', fn = ':tabnew | term lazygit<CR>',  desc = 'LazyGit в новом табе' },
  { key = '<leader>ls', fn = ':ls<CR>',               desc = 'список буферов'},
  { key = '<leader>lw', fn = ':wqa<CR>',              desc = 'сохранить все и выйти'},
  { key = '<leader>lc', fn = ':cq<CR>',               desc = 'отменить все и выйти'},

  { key = '<leader>lu', fn = ':diffupdate<CR>',       desc = 'diff: обновить подсветку'},
  { key = '<leader>ln', fn = ':]c<CR>',               desc = 'diff: следующий конфликт'},
  { key = '<leader>lp', fn = ':[c<CR>',               desc = 'diff: предыдущий конфликт'},

  { key = '<leader>ll', fn = ':diffget LOCAL<CR>',    desc = 'diff: взять LOCAL (ours)'},
  { key = '<leader>lb', fn = ':diffget BASE<CR>',     desc = 'diff: взять BASE'},
  { key = '<leader>lr', fn = ':diffget REMOTE<CR>',   desc = 'diff: взять REMOTE (theirs)'},

  { key = '<leader>lL', fn = ':%diffget LOCAL<CR>',   desc = 'diff: взять весь LOCAL (ours)'},
  { key = '<leader>lB', fn = ':%diffget BASE<CR>',    desc = 'diff: взять весь BASE'},
  { key = '<leader>lR', fn = ':%diffget REMOTE<CR>',  desc = 'diff: взять весь REMOTE (theirs)'},

  { key = '<leader>ll', fn = ':diffget LOCAL<CR>',    desc = 'diff: взять LOCAL (ours) в выделение',    mode = 'x' },
  { key = '<leader>lb', fn = ':diffget BASE<CR>',     desc = 'diff: взять BASE в выделение',            mode = 'x' },
  { key = '<leader>lr', fn = ':diffget REMOTE<CR>',   desc = 'diff: взять REMOTE (theirs) в выделение', mode = 'x'},
}

map_array(LAZYGIT_ACTIONS)
