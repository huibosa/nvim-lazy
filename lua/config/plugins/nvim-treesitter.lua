return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
            ensure_installed = {
                "rust",
                "go",
                "c",
                "cpp",
                "python",
            },
            indent = {
                enable = true,
            },
            highlight = {
                enable = false,
                addtional_vim_regex_highlighting = false,
                disable = function(_, buf) return vim.api.nvim_buf_line_count(buf) > 5000 end,
            },
            incremental_selection = {
                enable = false,
                keymaps = {
                    init_selection = "<CR>",
                    scope_incremental = "<CR>",
                    node_incremental = "v",
                    node_decremental = "V",
                },
            },
            match = {
                enable = true,
            },
        })
    end,
}
