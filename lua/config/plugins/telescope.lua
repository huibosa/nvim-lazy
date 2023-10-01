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

        telescope.setup({
            defaults = {
                path_display = { "truncate " },
                mappings = {
                    i = {
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["<Esc>"] = actions.close,
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
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find [files]" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[Grep] string" })
        vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[Recent] files" })
        vim.keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "[Cursor] string" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find [buffers]" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find [help]" })
    end,
}
