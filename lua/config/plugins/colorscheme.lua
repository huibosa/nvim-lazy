return {
    -- "sainnhe/gruvbox-material",
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
        -- vim.g.gruvbox_material_transparent_background = 1
        -- vim.cmd([[colorscheme gruvbox-material]])
        vim.g.everforest_transparent_background = 1
        vim.cmd([[colorscheme everforest]])
    end,
}
