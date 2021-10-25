local treesitter = require('nvim-treesitter.configs')

-- require'nvim-treesitter.configs'.setup { indent = { enable = true }, highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

-- Use a fork
local treesitter_parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
treesitter_parser_configs.cpp = {
  install_info = {
    url = "~/Applications/tree-sitter-cpp",
    files = { "src/parser.c", "src/scanner.cc" },
    generate_requires_npm = true,
  },
  maintainers = { "@theHamsta" },
}

treesitter.setup {
    ensure_installed = 'maintained',
    highlight = { enable = true, additional_vim_regex_highlighting = true },
    --indent = { enable = true },
}


