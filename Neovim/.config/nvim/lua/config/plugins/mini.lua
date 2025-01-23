-- lua/custom/plugins/mini.lua
return {
    {
        'echasnovski/mini.nvim',
        enabled = true,
        config = function()
            require('mini.basics').setup({
                options = { basic = true, extra_ui = false, win_borders = 'default' },
                mappings = { basic = true, windows = true, },
            })
            require('mini.statusline').setup { use_icons = true }
            require('mini.files').setup(
                {
                    windows = {
                        -- Maximum number of windows to show side by side
                        max_number = math.huge,
                        -- Whether to show preview of file/directory under cursor
                        preview = true,
                        -- Width of focused window
                        width_focus = 30,
                        -- Width of non-focused window
                        width_nofocus = 25,
                        -- Width of preview window
                        width_preview = 30,
                    },
                    mappings = {
                        close       = 'q',
                        go_in       = 'l',
                        go_in_plus  = '<CR>',
                        go_out      = 'h',
                        go_out_plus = 'H',
                        mark_goto   = "'",
                        mark_set    = 'm',
                        reset       = '<BS>',
                        reveal_cwd  = '@',
                        show_help   = 'g?',
                        synchronize = '=',
                        trim_left   = '<',
                        trim_right  = '>',
                    },
                }
            )
            require('mini.icons').setup()
            require('mini.pairs').setup()
            require('mini.ai').setup()
            require('mini.comment').setup()

            vim.opt.cursorline = false -- changing it here because mini.basics likes to turn it on by default

            local show_dotfiles = false

            local filter_show = function(fs_entry) return true end

            local filter_hide = function(fs_entry)
                return not vim.startswith(fs_entry.name, '.')
            end

            local toggle_dotfiles = function()
                show_dotfiles = not show_dotfiles
                local new_filter = show_dotfiles and filter_show or filter_hide
                MiniFiles.refresh({ content = { filter = new_filter } })
            end

            vim.api.nvim_create_autocmd('User', {
                pattern = 'MiniFilesBufferCreate',
                callback = function(args)
                    local buf_id = args.data.buf_id
                    -- Tweak left-hand side of mapping to your liking
                    vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
                end,
            })
        end
    }
}
