local M = {}

function M.map(mode, lhs, rhs, desc, opts)
  opts = vim.tbl_extend("force", { silent = true, desc = desc }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

---@param actions table[]   { key, fn, desc, mode?, opts?, cond? }
---@param defaults? { mode?: string|string[], prefix?: string, desc_prefix?: string, opts?: table }
function M.map_array(actions, defaults)
  defaults = defaults or {}
  for _, a in ipairs(actions) do
    local cond = a.cond
    if type(cond) == "function" then cond = cond() end
    if cond ~= false then
      local opts = vim.tbl_extend("force", defaults.opts or {}, a.opts or {})
      local desc = a.desc and (defaults.desc_prefix or "") .. a.desc or nil
      local lhs  = (defaults.prefix or "") .. a.key
      M.map(a.mode or defaults.mode or "n", lhs, a.fn, desc, opts)
    end
  end
end

return M
