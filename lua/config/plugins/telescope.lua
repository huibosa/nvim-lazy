return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        local state = require("telescope.state")
        local action_state = require("telescope.actions.state")

        local slow_scroll = function(prompt_bufnr, direction)
            local previewer = action_state.get_current_picker(prompt_bufnr).previewer
            local status = state.get_status(prompt_bufnr)

            -- Check if we actually have a previewer and a preview window
            if type(previewer) ~= "table" or previewer.scroll_fn == nil or status.preview_win == nil then return end

            previewer:scroll_fn(1 * direction)
        end

        telescope.setup({
            defaults = {
                path_display = { "truncate " },
                mappings = {
                    i = {
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["<Esc>"] = actions.close,
                        ["<C-e>"] = function(bufnr) slow_scroll(bufnr, 1) end,
                        ["<C-y>"] = function(bufnr) slow_scroll(bufnr, -1) end,
                    },
                },
                borderchars = { "━", "┃", "━", "┃", "┏", "┓", "┛", "┗" },
            },
        })

        telescope.load_extension("fzf")

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope<Cr>", { desc = "Telescope" })
        vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find [files]" })
        vim.keymap.set("n", "<C-q>", builtin.live_grep, { desc = "[Grep] string" })
        vim.keymap.set("n", "<leader>ff", builtin.current_buffer_fuzzy_find, { desc = "[Fuzzy] current buffer" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[Grep] string" })
        vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[Recent] files" })
        vim.keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "[Cursor] string" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find [buffers]" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find [help]" })
        vim.keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "Treesitter" })
    end,
}
