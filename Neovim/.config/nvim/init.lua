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

-- When editing a file, always jump to the last cursor position
if vim.fn.has("autocmd") == 1 then
    vim.api.nvim_create_autocmd("BufReadPost", {
        pattern = "*",
        callback = function()
            local last_cursor_pos = vim.fn.line("'\"")
            local current_line_count = vim.fn.line("$")
            if last_cursor_pos > 0 and last_cursor_pos <= current_line_count then
                vim.api.nvim_command("normal! g'\"")
            end
        end,
    })
end


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

-- handled by mini.basics
-- vim.api.nvim_create_autocmd('TextYankPost', {
--     desc = 'Highlight when yanking (copying) text',
--     group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
--     callback = function()
--         vim.highlight.on_yank()
--     end,
-- })

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

-- Quality of life improvements

vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>")

vim.keymap.set("n", "n", "nzzzv");
vim.keymap.set("n", "N", "Nzzzv");
vim.keymap.set("n", "J", "mzJ`z");

-- undo boundaries
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "!", "!<c-g>u")
vim.keymap.set("i", "?", "?<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- line movements
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<C-j>", "<esc>:m .+1<CR>==")
vim.keymap.set("i", "<C-k>", "<esc>:m .-2<CR>==")
vim.keymap.set("n", "<leader>k", ":m .-2<CR>==") -- probably not necessary, it's basically ddkP
vim.keymap.set("n", "<leader>j", ":m .+1<CR>==") -- probably not necessary, it's basically ddp but the cursor stays there

--better visual mode tabbing
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- classic mappings
-- vim.keymap.set("n", "<c-s>", ":w<CR>")
vim.keymap.set("i", "<c-s>", "<Esc>:w<CR>a")
vim.keymap.set("v", "<c-c>", "y")

vim.keymap.set("n", "<leader>y", ":%y+<cr>") -- might remove this one if I don't use it

-- managing windows - currently being handled by mini.basics
-- vim.keymap.set("n", "<C-h>", ":wincmd h<cr>")
-- vim.keymap.set("n", "<C-l>", ":wincmd l<cr>")
-- vim.keymap.set("n", "<C-j>", ":wincmd j<cr>")
-- vim.keymap.set("n", "<C-k>", ":wincmd k<cr>")
-- vim.keymap.set("n", "<M-h>", ":vertical resize -2<cr>")
-- vim.keymap.set("n", "<M-l>", ":vertical resize +2<cr>")
-- vim.keymap.set("n", "<M-j>", ":resize +2<cr>")
-- vim.keymap.set("n", "<M-k>", ":resize -2<cr>")

-- competitive programming
-- TODO update this to call make instead?
vim.api.nvim_create_autocmd("FileType", {
    pattern = "cpp",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<C-B>",
            ":wall | !g++ -std=c++17 -Wall -Wextra -Wshadow -Wno-unused-result -D local % -o %< <CR>",
            { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", "<C-Q>",
            ":wall | !g++ -std=c++17 -Wall -Wextra -O2 -Wshadow -Wfloat-equal -Wconversion -Wshift-overflow=2 -Wduplicated-cond -Wno-unused-result -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -fsanitize=address -fsanitize=undefined -fno-sanitize-recover -fsanitize=undefined % -D local -o %< <CR>g++ -std=c++17 -Wall -Wextra -Wshadow -Wno-unused-result -D local % -o %< <CR>",
            { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>r",
            ":wall | !g++ -std=c++17 -Wall -Wextra -Wshadow -Wno-unused-result % -D local -o %< && ./%< < in <CR>",
            { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>n",
            ":wall | !g++ -std=c++17 -Wall -Wextra -Wshadow -Wno-unused-result % -D local -o %< && ./%< <CR>",
            { noremap = true, silent = true })
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>r",
            ":wall | !python3 % < in <CR>",
            { noremap = true, silent = true })
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "c",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<C-B>",
            ":wall | !gcc -std=c17 -Wall -Wextra -Wshadow -Wno-unused-result % -D local -o %< <CR>",
            { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>n",
            ":wall | !gcc -std=c17 -Wall -Wextra -Wshadow -Wno-unused-result % -D local -o %< && ./%< <CR>",
            { noremap = true, silent = true })
    end
})
