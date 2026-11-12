local map_array = require("utils.keymap").map_array

-- одна обёртка вместо повторения require('fzf-lua') в каждой строке
local function fzf(method)
  return function() require("fzf-lua")[method]() end
end

local FZF_ACTIONS = {
  { key = '<leader>ff', fn = fzf('files'),                desc = 'Find files' },
  { key = '<leader>fg', fn = fzf('live_grep'),            desc = 'Live grep' },
  { key = '<leader>fb', fn = fzf('buffers'),              desc = 'Find buffers' },
  { key = '<leader>fh', fn = fzf('help_tags'),            desc = 'Find help tags' },

  { key = '<leader>fr', fn = fzf('resume'),     desc = 'Продолжить последний поиск' },
  { key = '<leader>fo', fn = fzf('oldfiles'),   desc = 'Недавние файлы' },
  { key = '<leader>fk', fn = fzf('keymaps'),    desc = 'Все маппинги' },
  { key = '<leader>fw', fn = fzf('grep_cword'), desc = 'Grep слово под курсором' },
  { key = '<leader>fs', fn = fzf('lsp_document_symbols'), desc = 'Символы документа' },

  -- diagnostics
  { key = '<leader>fd', fn = fzf('diagnostics_document'), desc = 'Find diagnostics' },
}

map_array(FZF_ACTIONS)
