-- local previewers = require('telescope.previewers')
-- local Job = require('plenary.job')

-- local new_maker = function(filepath, bufnr, opts)
-- filepath = vim.fn.expand(filepath)
-- Job:new({
-- command = 'file',
-- args = { '--mime-type', '-b', filepath },
-- on_exit = function(j)
-- local mime_type = vim.split(j:result()[1], '/')[1]
-- if mime_type == "text" then
-- previewers.buffer_previewer_maker(filepath, bufnr, opts)
-- else
-- -- maybe we want to write something to the buffer here
-- vim.schedule(function()
-- vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'BINARY' })
-- end)
-- end
-- end
-- }):sync()
-- end

local with_preview_2 = {
	winblend = 10,
	show_line = false,
	results_title = false,
	preview_title = false,
	layout_config = {
		preview_width = 0.5,
	},
	-- borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
}

local colorscheme_center_list = require("telescope.themes").get_dropdown({
	winblend = 10,
	width = 0.5,
	prompt = " ❯ ",
	results_height = 10,
	previewer = false,
})

require("telescope").load_extension("fzf")
-- require('telescope').load_extension('media_files')

local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		winblend = 10,
		prompt_prefix = "❯ ",
		selection_caret = "❯ ",
		mappings = {
			n = {
				["q"] = actions.close,
			},
			-- buffer_previewer_maker = new_maker,
			-- borderchars        = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
		},
		extensions = {
			fzy_native = {
				override_generic_sorter = true,
				override_file_sorter = true,
			},
			-- media_files = {
			--     filetypes = {"png", "webp", "jpg", "jpeg"},
			--     file_cmd = "rg" -- find command (defaults to `fd`)
			-- },
		},
	},
})

local M = {}

M.project_files = function()
	local opts = vim.deepcopy(with_preview_2) -- define here if you want to define something
	local ok = pcall(require("telescope.builtin").git_files, opts)
	if not ok then
		require("telescope.builtin").find_files(opts)
	end
end

M.change_colorscheme = function()
	local opts = vim.deepcopy(colorscheme_center_list) -- define here if you want to define something
	local ok = pcall(require("telescope.builtin").colorscheme, opts)
	if not ok then
        print("Couldn't change colorscheme")
	end
end

return M
