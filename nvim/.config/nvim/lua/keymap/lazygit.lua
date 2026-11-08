local prefix = "<leader>l"

local LAZYGIT_ACTIONS = {
  { key = "G", fn = "LazyGit", desc = "LazyGit: запуск LazyGit"},
  { key = "g", fn = "tabnew | term lazygit", desc = "LazyGit в новом табе" },
  { key = "s", fn = "ls", desc = "список буферов"},
  { key = "w", fn = "wqa", desc = "сохранить все и выйти"},
  { key = "c", fn = "cq", desc = "отменить все и выйти"},

  { key = "u", fn = "diffupdate", desc = "diff: обновить подсветку"},
  { key = "n", fn = "]c", desc = "diff: следующий конфликт"},
  { key = "p", fn = "[c", desc = "diff: предыдущий конфликт"},

  { key = "l", fn = "diffget LOCAL", desc = "diff: взять LOCAL (ours)"},
  { key = "b", fn = "diffget BASE", desc = "diff: взять BASE"},
  { key = "r", fn = "diffget REMOTE", desc = "diff: взять REMOTE (theirs)"},

  { key = "L", fn = "%diffget LOCAL", desc = "diff: взять весь LOCAL (ours)"},
  { key = "B", fn = "%diffget BASE", desc = "diff: взять весь BASE"},
  { key = "R", fn = "%diffget REMOTE", desc = "diff: взять весь REMOTE (theirs)"},

  { mode = "x", key = "l", fn = "diffget LOCAL", desc = "diff: взять LOCAL (ours) в выделение"},
  { mode = "x", key = "b", fn = "diffget BASE", desc = "diff: взять BASE в выделение"},
  { mode = "x", key = "r", fn = "diffget REMOTE", desc = "diff: взять REMOTE (theirs) в выделение"},
}

for _, action in ipairs(LAZYGIT_ACTIONS) do
  local mode = action.mode or "n"
  local cmd = ":"
  local keys = prefix .. action.key
  vim.keymap.set(mode, keys, cmd .. action.fn .. "<CR>", {
    desc = action.desc,
    noremap = true,
    silent = true
  })
end


-- vim.keymap.set("n", "<leader>lg", function()
--  vim.cmd("tabnew ")
--  vim.cmd("term lazygit")
--  vim.cmd("startinsert")
-- end, { desc = "Открыть терминал в новой вкладке" })
