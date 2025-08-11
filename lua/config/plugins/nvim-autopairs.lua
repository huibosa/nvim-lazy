return {
    "windwp/nvim-autopairs",
    enabled = true,
    event = { "InsertEnter" },
    config = function()
        local autopairs = require("nvim-autopairs")

        autopairs.setup({
            check_ts = true,        -- enable treesitter
            ts_config = {
                lua = { "string" }, -- don't add pairs in lua string treesitter nodes
            },
            map_c_h = true,
        })
    end,
}
