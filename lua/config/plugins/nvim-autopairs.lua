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

        -- Disable all backtick autocompletion:
        --   "```"      closing fence when typing the third backtick (markdown etc.)
        --   "```.*$"   fence auto-close on Enter (regex rule)
        --   "`"        single-backtick autopairing
        -- run after setup so the default basic/ts rules exist to remove
        autopairs.remove_rule("```")
        autopairs.remove_rule("```.*$")
        autopairs.remove_rule("`")
    end,
}
