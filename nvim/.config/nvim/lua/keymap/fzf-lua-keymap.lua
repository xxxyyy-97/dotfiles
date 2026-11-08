vim.keymap.set("n", "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true, desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>lua require('fzf-lua').live_grep()<CR>", { noremap = true, silent = true, desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>", { noremap = true, silent = true, desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>lua require('fzf-lua').help_tags()<CR>", { noremap = true, silent = true, desc = "Find help tags" })

--diagnostics_document
vim.keymap.set("n", "<leader>fd", "<cmd>lua require('fzf-lua').diagnostics_document()<CR>", { noremap = true, silent = true, desc = "Find diagnostics" })
