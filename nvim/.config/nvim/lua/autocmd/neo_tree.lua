vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "neo-tree" then
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.statuscolumn = ""
    end
  end,
})

--im.api.nvim_create_autocmd("FileType", {
 -- pattern = "neo-tree",
 -- callback = function()
  --  vim.opt_local.number = false
   -- vim.opt_local.relativenumber = false
  --  vim.opt_local.statuscolumn = ""
 -- end,
--})
