return {
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',

        version = '*',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- See the full "keymap" documentation for information on defining your own keymap.
            keymap = { preset = 'super-tab' },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- Will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default =
                    function(ctx)
                        local success, node = pcall(vim.treesitter.get_node)
                        if vim.bo.filetype == 'lua' then
                            return { 'lsp', 'path' }
                        elseif success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
                            return { 'buffer' }
                        else
                            return { 'lsp', 'path', 'snippets', 'buffer' }
                        end
                    end,
                min_keyword_length = function(ctx)
                    -- Snacks.notify(ctx.mode)                                   -- pretty useful for debugging
                    if ctx.trigger.kind == "trigger_character" then return 0 end -- might not be necessary in a future relese?
                    if ctx.trigger.kind == "manual" then return 0 end            -- same goes for this line
                    if ctx.mode == 'cmdline' then
                        return 0
                    elseif vim.bo.filetype == 'lua' then
                        return 2
                    else
                        return 3
                    end
                end
            },
            completion = {
                menu = {
                    border = 'single'
                },
                documentation = { window = { border = 'single' } },
                trigger = {
                    -- When true, will prefetch the completion items when entering insert mode
                    prefetch_on_insert = false,

                    -- When false, will not show the completion window automatically when in a snippet
                    show_in_snippet = true,

                    -- When true, will show the completion window after typing any of alphanumerics, `-` or `_`
                    show_on_keyword = true,

                    -- When true, will show the completion window after typing a trigger character
                    show_on_trigger_character = true,

                    show_on_blocked_trigger_characters = function()
                        if vim.api.nvim_get_mode().mode == 'c' then return {} end
                        return { ' ', '\n', '\t' }
                    end,

                    -- When both this and show_on_trigger_character are true, will show the completion window
                    -- when the cursor comes after a trigger character after accepting an item
                    show_on_accept_on_trigger_character = true,

                    -- When both this and show_on_trigger_character are true, will show the completion window
                    -- when the cursor comes after a trigger character when entering insert mode
                    show_on_insert_on_trigger_character = true,

                    -- List of trigger characters (on top of `show_on_blocked_trigger_characters`) that won't trigger
                    -- the completion window when the cursor comes after a trigger character when
                    -- entering insert mode/accepting an item
                    show_on_x_blocked_trigger_characters = { "'", '"', '(' },
                }
            },
            -- experimental signature help support
            -- signature = { enabled = true },
        },
        opts_extend = { "sources.default" },
        enabled = true,
    },
}
