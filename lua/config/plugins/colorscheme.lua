return {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.everforest_transparent_background = 1
        vim.g.everforest_better_performance = 1
        vim.g.everforest_current_word = "grey background"

        vim.cmd([[colorscheme everforest]])
    end,
}
