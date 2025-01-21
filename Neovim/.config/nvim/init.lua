require("config.lazy")

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.timeoutlen = 500
vim.opt.scrolloff = 5
vim.opt.swapfile = false
vim.wo.number = true

vim.cmd [[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o "stops comments from showing up on newlines]]
vim.cmd [[autocmd BufEnter * silent! lcd %:p:h]]

local function set_rnu()
    if vim.bo.filetype:match('dashboard') or vim.bo.filetype:match('minifiles') then
        return
    end
    vim.wo.relativenumber = true
end
local function set_nornu()
    if vim.bo.filetype:match('dashboard') or vim.bo.filetype:match('minifiles') then
        return
    end
    vim.wo.relativenumber = false
end
vim.api.nvim_create_augroup('numbertoggle', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave' }, {
    group = 'numbertoggle',
    callback = set_rnu
})
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter' }, {
    group = 'numbertoggle',
    callback = set_nornu
})

vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("i", "JK", "<Esc>")
vim.keymap.set("i", "Jk", "<Esc>")
vim.keymap.set("c", "jk", "<Esc>")
vim.keymap.set("c", "kj", "<Esc>")
vim.keymap.set("c", "JK", "<Esc>")
vim.keymap.set("c", "Jk", "<Esc>")

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
vim.keymap.set('n', 'grr', vim.lsp.buf.references)

vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
})

local job_id = 0
vim.keymap.set("n", "<space>st", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 15)

    job_id = vim.bo.channel
end)

vim.keymap.set("n", "<space>example", function()
    vim.fn.chansend(job_id, { "echo 'hi'\r\n" })
end)

vim.keymap.set("n", "-", "<cmd>lua MiniFiles.open()<CR>")
