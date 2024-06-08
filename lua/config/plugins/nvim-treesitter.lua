return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
            ensure_installed = {
                "rust",
                "go",
                "c",
                "cpp",
            },
            indent = {
                enable = true,
            },
            highlight = {
                enable = true,
                addtional_vim_regex_highlighting = false,
                disable = function(lang, buf)
                    -- Check if disabled languages
                    local disabled_lang = false
                    local lang_list = { "go", "c", "cpp", "bash" }
                    for _, str in ipairs(lang_list) do
                        if str == lang then disabled_lang = true end
                    end

                    -- Check if is large file
                    local large_file = vim.api.nvim_buf_line_count(buf) > 5000

                    return disabled_lang or large_file
                end,
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
