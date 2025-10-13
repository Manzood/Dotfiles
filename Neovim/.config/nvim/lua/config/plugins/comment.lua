return {
    {
        'numToStr/Comment.nvim',
        -- event = "VeryLazy",
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        config = function()
            require('Comment').setup {
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
                ignore = '^$', -- ignores empty lines
            }
            vim.keymap.set('n', '<C-/>', function() require('Comment.api').toggle.linewise.current() end,
                { desc = "Toggle comment line" })
            -- vim.keymap.set('v', '<C-/>',
            --     "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
            --     { desc = "Toggle comment selection" })
        end
    }
}
