
vim.pack.add({
	{src = "https://github.com/akinsho/bufferline.nvim"},
})

--local tokyonight = require("tokyonight.colors")

require("bufferline").setup({
  options = {
    mode = "buffers", -- или "tabs"
    always_show_bufferline = true,
    show_buffer_close_icons = true,
    show_close_icon = false,
    show_buffer_numbers = true,
    separator_style = "thin", -- или "thick", "thin"
    enforce_regular_tabs = false,
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
    },
  },
})

require("keymap.bufferline-keymap")
