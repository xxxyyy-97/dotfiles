vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local opts = { buffer = ev.buf, noremap = true, silent = true }
		if not client then
			return
		end

		if client and client:supports_method("textDocument/completion") then
			vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })

			-- Ручной вызов автодополнения по Ctrl+Space
			vim.keymap.set("i", "<C-Space>", function()
				vim.lsp.completion.get()
			end, { buffer = ev.buf })

			-- Показать документацию при наведении курсора
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

			-- Перейти к определению символа
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

			-- Отформатировать файл через LSP
			vim.keymap.set("n", "<leader>fo", function()
				vim.lsp.buf.format({ async = true })
			end, opts)

			-- Переименовать символ во всём проекте
			vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
		end
	end,
})
