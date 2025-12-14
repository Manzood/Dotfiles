local B = {}

B.setup = function()
    vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)
    vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files)
    vim.keymap.set("n", "<D-p>", require('telescope.builtin').git_files)
    vim.keymap.set("n", "<leader>fc", require('telescope.builtin').colorscheme)
    -- search through nvim config
    vim.keymap.set("n", "<space>en", function()
        local opts = require('telescope.themes').get_ivy({
            cwd = vim.fn.stdpath("config")
        })
        require('telescope.builtin').find_files(opts)
    end)
    -- search neovim plugins
    vim.keymap.set("n", "<space>ep", function()
        require('telescope.builtin').find_files {
            cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
        }
    end)
    -- find snippets
    vim.keymap.set("n", "<space>fs", function()
        local chosen_cwd = "/home/manzood/Coding/Competitive-Programming/snippets"
        if vim.fn.has("macunix") then
            chosen_cwd = "/Users/manzood/Coding/competitive-programming/snippets"
        end
        local opts = require('telescope.themes').get_ivy({
            cwd = chosen_cwd,
            prompt_prefix = "Snippets ❯ ",
        })
        require('telescope.builtin').find_files(opts)
    end)
    -- search through current contest files
    vim.keymap.set("n", "<space>cf", function()
        local opts = require('telescope.themes').get_ivy({
            cwd = "../",
            prompt_prefix = "Contest ❯ ",
        })
        require('telescope.builtin').find_files(opts)
    end)
end

return B
