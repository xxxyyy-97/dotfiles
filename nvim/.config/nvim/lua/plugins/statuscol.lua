-- говорят эта штука выравнивает номера строк как в Lazynim 
vim.pack.add({
  { src = "https://github.com/luukvbaal/statuscol.nvim"},
})

local builtin = require("statuscol.builtin")
require("statuscol").setup({
  relculright = true, -- правое выравнивание текущего номера (та самая фича из LazyVim)
  segments = {
    { text = { builtin.foldfunc }, click = "v:lua.ScFa" },  -- фолды
    { text = { "%s" },             click = "v:lua.ScSa" },  -- signs (git, diagnostics)
    { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" }, -- номера строк
  },
})
