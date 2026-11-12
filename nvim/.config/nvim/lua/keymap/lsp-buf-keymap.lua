local km = require("utils.keymap")

local M = {}

--- Буферные LSP-кеймапы. Вызывается из LspAttach.
---@param bufnr integer
---@param client vim.lsp.Client
function M.attach(bufnr, client)
  local function has(method)
    return client:supports_method(method, bufnr)
  end

  -- побочный эффект, не маппинг — оставляем отдельным блоком
  if has("textDocument/completion") then
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
  end

  local ACTIONS = {
    -- ─── Completion ─────────────────────────────────────────────
    { key = '<C-Space>',  mode = 'i',                        fn = vim.lsp.completion.get, desc = 'completion',                      cond = has('textDocument/completion') },

    -- ─── Навигация ──────────────────────────────────────────────
    { key = '<leader>gh', fn = vim.lsp.buf.hover,            desc = 'hover',              cond = has('textDocument/hover') },
    { key = '<leader>gd', fn = vim.lsp.buf.definition,       desc = 'definition',         cond = has('textDocument/definition') },
    { key = '<leader>gD', fn = vim.lsp.buf.declaration,      desc = 'declaration',        cond = has('textDocument/declaration') },
    { key = '<leader>gr', fn = vim.lsp.buf.references,       desc = 'references',         cond = has('textDocument/references') },
    { key = '<leader>gi', fn = vim.lsp.buf.implementation,   desc = 'implementation',     cond = has('textDocument/implementation') },
    { key = '<leader>gy', fn = vim.lsp.buf.type_definition,  desc = 'type definition',    cond = has('textDocument/typeDefinition') },
    { key = '<leader>gs', fn = vim.lsp.buf.document_symbol,  desc = 'document symbols',   cond = has('textDocument/documentSymbol') },
    { key = '<leader>gw', fn = vim.lsp.buf.workspace_symbol, desc = 'workspace symbols',  cond = has('workspace/symbol') },

    -- ─── Действия ───────────────────────────────────────────────
    { key = '<leader>gn', fn = vim.lsp.buf.rename,           desc = 'rename',             cond = has('textDocument/rename') },
    { key = '<leader>ga', fn = vim.lsp.buf.code_action,      desc = 'code action',        mode = { 'n', 'v' },                      cond = has('textDocument/codeAction') },
    {
      key = '<leader>gf',
      desc = 'format',
      mode = { 'n', 'v' },
      cond = has('textDocument/formatting') or has('textDocument/rangeFormatting'),
      fn = function() vim.lsp.buf.format({ async = true, bufnr = bufnr }) end
    },

    -- ─── Диагностика (от сервера не зависит) ────────────────────
    { key = '<leader>ge', fn = vim.diagnostic.open_float, desc = 'line diagnostics' },
    { key = '<leader>gq', fn = vim.diagnostic.setloclist, desc = 'diagnostics to loclist' },
  }

  -- «в одном месте»: буферность и префикс описания для всей группы
  km.map_array(ACTIONS, {
    desc_prefix = 'LSP: ',
    opts = { buffer = bufnr },
  })
end

return M
