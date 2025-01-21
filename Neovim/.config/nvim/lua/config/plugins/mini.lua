-- lua/custom/plugins/mini.lua
return {
    {
        'echasnovski/mini.nvim',
        config = function()
            require('mini.statusline').setup { use_icons = true }
            require('mini.files').setup()
            -- require('mini.completion').setup()
            require('mini.icons').setup()
            require('mini.pairs').setup()
        end
    }
}
