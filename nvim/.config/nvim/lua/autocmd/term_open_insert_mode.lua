vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(ev)
    if vim.bo[ev.buf].buftype == "terminal" then
      vim.cmd.startinsert()
    end
  end,
})
