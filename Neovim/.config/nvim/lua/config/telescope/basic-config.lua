local B = {}

B.setup = function()
    vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)
    vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files)
    vim.keymap.set("n", "<C-p>", function()
        local obsidian = vim.fs.find(".obsidian", {
            upward = true,
            type = "directory",
            path = vim.fn.getcwd(),
        })
        if #obsidian > 0 then
            local vault_root = vim.fn.fnamemodify(obsidian[1], ":h")
            require('telescope.builtin').find_files({
                cwd = vault_root,
                prompt_prefix = "Vault ❯ ",
            })
        else
            require('telescope.builtin').git_files()
        end
    end)
    vim.keymap.set("n", "<leader>fc", require('telescope.builtin').colorscheme)
    -- search through nvim config
    vim.keymap.set("n", "<leader>en", function()
        local opts = require('telescope.themes').get_ivy({
            cwd = vim.fn.stdpath("config")
        })
        require('telescope.builtin').find_files(opts)
    end)
    vim.keymap.set("n", "<leader>os", function()
        local opts = require('telescope.themes').get_ivy({
            cwd = '/Users/manzood/Notes/obsidian/Personal'
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
