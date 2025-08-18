return {
    "echasnovski/mini.files",
    keys = { "-" },
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        local mini = require("mini.files")

        -- https://www.reddit.com/r/neovim/comments/1bceiw2/comment/kuhmdp9/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
        vim.keymap.set('n', '-', mini.open, { desc = "Open MiniFiles" })

        -- mini.setup {
        --     mappings = {
        --         synchronize = "w",
        --         go_in_plus = "<CR>" },
        -- }

        local show_dotfiles = true

        local filter_show = function(_)
            return true
        end

        local filter_hide = function(fs_entry)
            return not vim.startswith(fs_entry.name, ".")
        end

        -- local gio_open = function()
        --     local fs_entry = mini.get_fs_entry()
        --     vim.notify(vim.inspect(fs_entry))
        --     vim.fn.system(string.format("gio open '%s'", fs_entry.path))
        -- end

        local toggle_dotfiles = function()
            show_dotfiles = not show_dotfiles
            local new_filter = show_dotfiles and filter_show or filter_hide
            mini.refresh { content = { filter = new_filter } }
        end

        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniFilesBufferCreate",
            callback = function(args)
                local buf_id = args.data.buf_id
                -- Tweak left-hand side of mapping to your liking
                vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
                vim.keymap.set("n", "-", mini.close, { buffer = buf_id })
                -- vim.keymap.set("n", "o", gio_open, { buffer = buf_id })
            end,
        })
    end,
}
