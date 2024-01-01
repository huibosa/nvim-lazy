return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
            ensure_installed = {
                "json",
                "markdown",
                "markdown_inline",
                "dockerfile",
                "gitignore",
                "go",
                "c",
                "cpp",
                "bash",
                "lua",
                "csv",
                "python",
                "vim",
                "regex",
            },
            auto_install = true,
            indent = {
                enable = true,
            },
            highlight = {
                enable = true,
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
