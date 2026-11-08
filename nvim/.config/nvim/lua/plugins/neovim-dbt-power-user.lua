vim.pack.add({
  {
    src = 'https://github.com/BfdCampos/neovim-dbt-power-user',
    name = 'dbt-power-user.nvim'
  },
  -- dependencies
  "https://github.com/MunifTanjim/nui.nvim",
  --"https://github.com/folke/snacks.nvim", -- вынес отдельно
  "https://github.com/Saghen/blink.lib",
  "https://github.com/Saghen/blink.cmp",  -- для автодополнения ref() и source()

})

require("dbt-power-user").setup({
  prefix = "<leader>d", -- или любой другой префикс
--  dbt_cmd = "/home/docker/bin/dbt",
})

require("keymap.neovim-dbt-power-user")
