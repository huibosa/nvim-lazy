return {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.gruvbox_material_background = "medium"
        vim.g.gruvbox_material_better_performance = 1
        vim.g.gruvbox_material_current_word = "grey background"

        vim.cmd([[colorscheme gruvbox-material]])
    end,
}
