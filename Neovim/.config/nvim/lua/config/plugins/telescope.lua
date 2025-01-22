return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
        local telescope_ignore_patterns = {
            --[[ "[^a-z]test[^a-z]", ]]
            --[[ "[^a-z]mock[^a-z]", ]]
            --[[ "[^a-z]stub[^a-z]", ]]
            --[[ "Test[^a-z]", ]]
            --[[ "Mock[^a-z]", ]]
            --[[ "Stub[^a-z]", ]]
            "%.bin",
            "%.cmake",
            "%.make",
            "a.out",
            "%.log",
            "%.check_cache",
            "%.marks",
        }
        vim.g.telescope_ignore_enabled = true
        vim.keymap.set("n", "<leader>uI", function()
            vim.g.telescope_ignore_enabled = not vim.g.telescope_ignore_enabled

            require("telescope.config").set_defaults({
                file_ignore_patterns = vim.g.telescope_ignore_enabled and telescope_ignore_patterns or {},
            })
        end, { noremap = true, desc = "Toggle telescope ignore patterns" })

        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                        -- map actions.which_key to <C-h> (default: <C-/>)
                        ["<C-h>"] = "which_key"
                    }
                },
                file_ignore_patterns = telescope_ignore_patterns,
            },
            pickers = {
                -- picker_name = {
                --   picker_config_key = value,
                --   ...
                -- }
            },
            extensions = {
                fzf = {}
            }
        }

        require('telescope').load_extension('fzf')
        require "config/telescope.basic-config".setup()
        require "config.telescope.multigrep".setup()
    end
}
