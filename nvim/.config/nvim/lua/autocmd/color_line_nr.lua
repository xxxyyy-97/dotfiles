vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, 'CursorLineNr', {
      fg = '#ff9e64',    -- цвет tokyonight для CursorLineNr
      bold = false,      -- главное — убрать bold
    })
  end,
})
