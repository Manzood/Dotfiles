local treesitter = require('nvim-treesitter.configs')

-- require'nvim-treesitter.configs'.setup { indent = { enable = true }, highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}


-- Installing Parsers:

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

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.org = {
--   install_info = {
--     url = 'https://github.com/milisims/tree-sitter-org',
--     revision = 'f110024d539e676f25b72b7c80b0fd43c34264ef',
--     files = {'src/parser.c', 'src/scanner.cc'},
--   },
--   filetype = 'org',
-- }

local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
}



treesitter.setup {
    ensure_installed = 'maintained',
    highlight = {
        enable = true,
        -- disable = {'org'},
        additional_vim_regex_highlighting = false,
        -- additional_vim_regex_highlighting = {'org'},
    },
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


-- require('orgmode').setup({
--   -- org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
--   org_agenda_files = {'~/Notes/my-orgs/*'},
--   -- org_default_notes_file = '~/Dropbox/org/refile.org',
--   org_default_notes_file = '~/Notes/my-orgs/Today.org',
-- })

