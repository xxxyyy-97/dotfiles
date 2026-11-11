local M = {}

--- Буферные LSP-кеймапы. Вызывается из LspAttach.
---@param bufnr integer
---@param client vim.lsp.Client
function M.attach(bufnr, client)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = "LSP: " .. desc })
  end

  --- Маппинг только если сервер поддерживает метод
  local function cap_map(method, mode, lhs, rhs, desc)
    if client:supports_method(method) then
      map(mode, lhs, rhs, desc)
    end
  end

  -- ─── Completion ───────────────────────────────────────────────
  if client:supports_method("textDocument/completion") then
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    map("i", "<C-Space>", function() vim.lsp.completion.get() end, "completion")
  end

  -- ─── Навигация ────────────────────────────────────────────────
  -- cap_map("textDocument/hover", "n", "K", vim.lsp.buf.hover, "hover")
  cap_map("textDocument/hover", "n", "<leader>gh", vim.lsp.buf.hover, "hover")
  cap_map("textDocument/definition", "n", "<leader>gd", vim.lsp.buf.definition, "definition")
  cap_map("textDocument/declaration", "n", "<leader>gD", vim.lsp.buf.declaration, "declaration")
  cap_map("textDocument/references", "n", "<leader>gr", vim.lsp.buf.references, "references")
  cap_map("textDocument/implementation", "n", "<leader>gi", vim.lsp.buf.implementation, "implementation")
  cap_map("textDocument/typeDefinition", "n", "<leader>gy", vim.lsp.buf.type_definition, "type definition")
  cap_map("textDocument/documentSymbol", "n", "<leader>gs", vim.lsp.buf.document_symbol, "document symbols")
  cap_map("workspace/symbol", "n", "<leader>gw", vim.lsp.buf.workspace_symbol, "workspace symbols")

  -- ─── Действия ─────────────────────────────────────────────────
  cap_map("textDocument/rename", "n", "<leader>gn", vim.lsp.buf.rename, "rename")
  cap_map("textDocument/codeAction", { "n", "v" }, "<leader>ga", vim.lsp.buf.code_action, "code action")

  if client:supports_method("textDocument/formatting")
    or client:supports_method("textDocument/rangeFormatting") then
    map({ "n", "v" }, "<leader>gf", function()
      vim.lsp.buf.format({ async = true, bufnr = bufnr })
    end, "format")
  end

  -- ─── Диагностика ──────────────────────────────────────────────
  map("n", "<leader>ge", vim.diagnostic.open_float, "line diagnostics")
  map("n", "<leader>gq", vim.diagnostic.setloclist, "diagnostics to loclist")
end

return M
