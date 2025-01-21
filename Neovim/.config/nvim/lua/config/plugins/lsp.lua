return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                -- "saghen/blink.cmp",
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
                lua_ls = {},
                clangd = {}
            }
        },
        config = function(_, opts)
            local lspconfig = require('lspconfig')
            for server, config in pairs(opts.servers) do
                -- config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                -- probably want to change this to nvim-cmp, it served me quite well
                -- I'd also like some kind of a nerd font
                lspconfig[server].setup(config)
            end

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then return end

                    ---@diagnostic disable-next-line: missing-parameter
                    if client.supports_method('textDocument/formatting') then
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
            -- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })]]
        end,
    }
}
