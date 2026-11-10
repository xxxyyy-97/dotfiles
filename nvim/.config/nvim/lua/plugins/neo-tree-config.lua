vim.pack.add({
	{
		src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
	},
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

require("neo-tree").setup({
  use_popups_for_input = false,
  -- === Глобальные настройки ===
  close_if_last_window = false,
  enable_cursor_hijack = true,
  enable_opened_markers = true,

  -- === Настройки файловой системы ===
  filesystem = {
    bind_to_cwd = false,
    follow_current_file = {
      enabled = false,
      leave_dirs_open = false,
    },

    group_empty_dirs = true,
    use_libuv_file_watcher = false,
    enable_refresh_on_write = true,

    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = false,
      -- hide_by_name = {
      --   ".DS_Store",
      --   "thumbs.db",
      -- },
      -- never_show = {
      --   ".git",
      -- },
    },
  },

  -- === Правила вложенности ===
  nesting_rules = {},
  event_handlers = {
    {
      event = "neo_tree_buffer_enter",
      handler = function(state)
        -- state — это объект состояния Neo-tree, передаётся автоматически
        if state and state.name == "filesystem" then
          require("neo-tree.sources.filesystem").refresh(state)
        end
        end,
    },
  },
  window = {
    position = "left",
    width = 35,
    mappings = {
      --    ["<space>"] = "toggle_node",
      ["o"] = "open",
      ["<cr>"] = "open",
      ["P"] = "toggle_preview",
      ["z"] = "close_all_nodes",
    },
  },
  })

require("keymap.neo-tree-keymap")
