-- lua/custom/plugins/mini.lua
return {
    {
        'echasnovski/mini.nvim',
        enabled = true,
        config = function()
            require('mini.basics').setup({
                options = { basic = true, },
                set = { cursorline = false },
                mappings = { basic = true, windows = true, },
            })
            require('mini.statusline').setup { use_icons = true }
            require('mini.files').setup()
            require('mini.icons').setup()
            require('mini.pairs').setup()
            require('mini.ai').setup()
            require('mini.comment').setup()
            vim.opt.cursorline = false -- changing it here because mini.basics likes to turn it on by default
        end
    }
}
