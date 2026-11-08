vim.pack.add({
  {
    src ="https://github.com/kdheepak/lazygit.nvim",
    cmd ={"LazyGit"},
    dependencies = {"nvim-lua/plenary.nvim"},
  },
})

require("keymap.lazygit")
