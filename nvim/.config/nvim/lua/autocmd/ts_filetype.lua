vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TsSetup", { clear = true }),
  callback = function(args)
    local buf = args.buf

    local has_parser = pcall(vim.treesitter.get_parser, buf)
    if not has_parser then
      return
    end

    pcall(vim.treesitter.start, buf)

    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
