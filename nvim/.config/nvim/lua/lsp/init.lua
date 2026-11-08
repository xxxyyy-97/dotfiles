require("lsp.lua_ls")
require("lsp.rust-analyzer")
require("lsp.pyright")

--vim.lsp.enable('lua_ls')

--vim.lsp.enable('rust')
vim.lsp.enable({
	"rust-analyzer",
	"lua_ls",
  "pyright",
})


vim.diagnostic.config({
  --virtual_text = true,
  virtual_lines = true,
 -- virtual_lines = {current_line = true}
})

