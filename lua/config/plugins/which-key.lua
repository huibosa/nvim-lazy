return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
        -- window = {
        --     border = vim.g.window_borders, -- none, single, double, shadow
        --     position = "bottom", -- bottom, top
        --     margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
        --     padding = { 1, 0, 1, 0 }, -- extra window padding [top, right, bottom, left]
        -- },
        -- layout = {
        --     height = { min = 1, max = 25 }, -- min and max height of the columns
        --     width = { min = 20, max = 50 }, -- min and max width of the columns
        --     spacing = 5, -- spacing between columns
        --     align = "center", -- align columns left, center or right
        -- },
        key_labels = {
            ["<space>"] = "SPC",
            ["<cr>"] = "RET",
            ["<tab>"] = "TAB",
        },
        mappings = {
            ["g"] = { name = "+goto" },
            ["gs"] = { name = "+surround" },
            ["]"] = { name = "+next" },
            ["["] = { name = "+prev" },
            ["<leader>f"] = { name = "+file/find" },
            ["<leader>c"] = { name = "+code" },
            ["<leader><leader>"] = { "FzfLua" },
            ["<leader>h"] = { "hunk" },
            ["<leader>cw"] = { "workspace" },
        },
    },
    config = function(_, opts)
        local wk = require("which-key")

        wk.setup(opts)
        wk.register(opts.mappings)
    end,
}
