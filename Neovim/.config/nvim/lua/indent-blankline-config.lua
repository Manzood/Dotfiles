-- Refer to help indent-blankline-variables
-- vim.opt.list = true
-- vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup({
	show_end_of_line = true,
	filetype_exclude = { "dashboard", "", "help" },
	-- show_current_context = true,
	-- show_current_context_start = true,
})
