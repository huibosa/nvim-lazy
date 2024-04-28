return {
    "sainnhe/everforest",
    lazy = true,
    config = function()
        vim.g.everforest_background = "hard"
        vim.g.everforest_better_performance = 1
        vim.g.everforest_current_word = "grey background"

        -- vim.cmd([[colorscheme everforest]])
    end,
}
