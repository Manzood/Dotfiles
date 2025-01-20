-- context_commentstring nvim-treesitter module is deprecated, use require('ts_context_commentstring').setup {} and set vim.g.skip_ts_context_commentstring_modu
-- le = true to speed up loading instead.
-- Feature will be removed in ts_context_commentstring in the future (see https://github.com/JoosepAlviste/nvim-ts-context-commentstring/issues/82 for more info
-- )
-- stack traceback:
--         ...-commentstring/lua/ts_context_commentstring/internal.lua:144: in function 'attach'
--         .../plugged/nvim-treesitter/lua/nvim-treesitter/configs.lua:509: in function 'attach_module'
--         .../plugged/nvim-treesitter/lua/nvim-treesitter/configs.lua:532: in function 'reattach_module'
--         .../plugged/nvim-treesitter/lua/nvim-treesitter/configs.lua:133: in function <.../plugged/nvim-treesitter/lua/nvim-treesitter/configs.lua:132>
--         [C]: in function 'nvim_cmd'
--         /tmp/.mount_nvimIcui4z/usr/share/nvim/runtime/filetype.lua:36: in function </tmp/.mount_nvimIcui4z/usr/share/nvim/runtime/filetype.lua:35>
--         [C]: in function 'nvim_buf_call'
--         /tmp/.mount_nvimIcui4z/usr/share/nvim/runtime/filetype.lua:35: in function </tmp/.mount_nvimIcui4z/usr/share/nvim/runtime/filetype.lua:10>

require('ts_context_commentstring').setup {
  enable_autocmd = false,
}

vim.g.skip_ts_context_commentstring_module = true
local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
  return option == "commentstring"
    and require("ts_context_commentstring.internal").calculate_commentstring()
    or get_option(filetype, option)
end
