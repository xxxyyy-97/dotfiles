vim.pack.add({
	{src = "https://github.com/mason-org/mason.nvim"},
	"https://github.com/mason-org/mason-lspconfig.nvim"
})

require("mason").setup({})
-- local mason_lspconfig = require("mason-lspconfig")
-- mason_lspconfig.setup {
--     ensure_installed = {"pyright"}
-- }
