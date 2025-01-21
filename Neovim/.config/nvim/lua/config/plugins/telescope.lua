return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	-- or                              , branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim',
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
	},
	config = function()
		require('telescope').setup {
			defaults = {
				-- Default configuration for telescope goes here:
				-- config_key = value,
				mappings = {
					i = {
						-- map actions.which_key to <C-h> (default: <C-/>)
						-- actions.which_key shows the mappings for your picker,
						-- e.g. git_{create, delete, ...}_branch for the git_branches picker
						["<C-h>"] = "which_key"
					}
				}
			},
			pickers = {
				-- Default configuration for builtin pickers goes here:
				-- picker_name = {
				--   picker_config_key = value,
				--   ...
				-- }
				-- Now the picker_config_key will be applied every time you call this
				-- builtin picker
			},
			extensions = {
				-- Your extension configuration goes here:
				-- extension_name = {
				--   extension_config_key = value,
				-- }
				-- please take a look at the readme of the extension you want to configure
				fzf = {}
			}
		}
		require('telescope').load_extension('fzf')
		vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)
		vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files)
		vim.keymap.set("n", "<C-P>", require('telescope.builtin').git_files)
		vim.keymap.set("n", "<space>cc", function()
			local opts = require('telescope.themes').get_ivy({
				cwd = vim.fn.stdpath("config")
			})
			require('telescope.builtin').find_files(opts)
		end)
		vim.keymap.set("n", "<space>ep", function()
			require('telescope.builtin').find_files {
				cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
			}
		end)

		require "config.telescope.multigrep".setup()
	end
}
