local treesitter = require('nvim-treesitter.configs')

-- require'nvim-treesitter.configs'.setup { indent = { enable = true }, highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

-- Use a fork
-- local treesitter_parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
-- treesitter_parser_configs.cpp = {
  -- install_info = {
    -- url = "~/Applications/tree-sitter-cpp",
    -- files = { "src/parser.c", "src/scanner.cc" },
    -- generate_requires_npm = true,
  -- },
  -- maintainers = { "@theHamsta" },
-- }

treesitter.setup {
    ensure_installed = 'maintained',
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    --indent = { enable = true },
    indent = {
        enable = true,
        disable = { 'cpp' },
    },
    -- context_commentstring = {
    --     enable = true,
    -- },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
}