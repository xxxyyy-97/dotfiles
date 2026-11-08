
vim.pack.add({
	{src = "https://github.com/ibhagwan/fzf-lua",
    name = "fzf-lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
})

require("fzf-lua").setup({})
require("keymap.fzf-lua-keymap")
