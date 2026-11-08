vim.pack.add({
	{src = "https://github.com/CopilotC-Nvim/CopilotChat.nvim"},
})
require("CopilotChat").setup()
require("keymap.copilot-chat")
