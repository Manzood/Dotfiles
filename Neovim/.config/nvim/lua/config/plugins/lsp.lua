return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "saghen/blink.cmp",
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        opts = {
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = {
                                version = 'LuaJIT',                  -- Neovim uses LuaJIT
                                path = vim.split(package.path, ';'), -- Include Neovim runtime paths
                            },
                            diagnostics = {
                                globals = { 'vim' }, -- Tell LSP that 'vim' is a global variable
                            },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true), -- Make Neovim's runtime available
                            },
                            telemetry = {
                                enable = false, -- Disable telemetry
                            },
                        },
                    },
                },
                clangd = {}
            }
        },
        config = function(_, opts)
            vim.diagnostic.config({ virtual_text = true });
            local lspconfig = require('lspconfig')
            for server, config in pairs(opts.servers) do
                -- blink.nvim
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities) -- TODO wrap this in some kind of if statement?

                -- -- specific clangd config
                -- if server == "clangd" then
                --     config.cmd = {
                --         "/opt/homebrew/opt/llvm/bin/clangd",
                --         "--enable-config",
                --         "--query-driver=/opt/homebrew/opt/gcc/bin/g++-15,/opt/homebrew/opt/gcc/bin/gcc-15",
                --     }
                --     config.on_init = function(client)
                --         client.config.cmd_env = client.config.cmd_env or {}
                --         client.config.cmd_env.PATH = os.getenv("HOME") .. "/.local/bin:" .. os.getenv("PATH")
                --     end
                -- end

                lspconfig[server].setup(config)

                -- classic config
                -- lspconfig[server].setup{}

                -- nvim-cmp
                -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
                -- lspconfig[server].setup {
                --     capabilities = capabilities
                -- }
            end

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded",
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then return end

                    ---@diagnostic disable-next-line: missing-parameter
                    if client:supports_method('textDocument/formatting') then
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ buffer = args.buf, id = client.id })
                            end
                        })
                    end
                end,
            })

            vim.keymap.set("n", "<space>ff", function() vim.lsp.buf.format() end)
            vim.keymap.set("n", "<space>rn", function() vim.lsp.buf.rename() end)
            vim.keymap.set("n", "<space>ca", function() vim.lsp.buf.code_action() end)
            vim.keymap.set("n", "<space>gr", function() vim.lsp.buf.references() end)
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
            vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end)
            vim.keymap.set("n", "<leader>q", function() vim.diagnostic.setloclist() end)
        end,
    }
}
