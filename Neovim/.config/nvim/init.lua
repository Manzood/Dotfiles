require("config.lazy")

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
-- vim.opt.clipboard = "unnamedplus" -- I don't think I like this option

vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("i", "JK", "<Esc>")
vim.keymap.set("i", "Jk", "<Esc>")
vim.keymap.set("c", "jk", "<Esc>")
vim.keymap.set("c", "kj", "<Esc>")
vim.keymap.set("c", "JK", "<Esc>")
vim.keymap.set("c", "Jk", "<Esc>")

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
