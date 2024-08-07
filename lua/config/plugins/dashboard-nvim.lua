return {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        theme = "hyper",
        shortcut_type = "letter",
        config = {
            disable_move = true,
            week_header = { enable = true },
            packages = { enable = true },
            project = { enable = true, limit = 4, action = "FzfLua files cwd=" },
            mru = { limit = 8 },
            footer = { "", "🚀 Practice, practice, practice" },
            shortcut = {
                {
                    icon = " ",
                    desc = "New",
                    group = "@character",
                    action = "enew",
                    key = "n",
                },
                {
                    icon = "   ",
                    desc = "Find",
                    group = "Label",
                    action = "FzfLua files",
                    key = "f",
                },
                {
                    icon = "  󰈚 ",
                    desc = "Recent",
                    group = "@module",
                    action = "FzfLua oldfiles",
                    key = "r",
                },
                {
                    icon = "   ",
                    desc = "Grep",
                    group = "@property",
                    action = "FzfLua live_grep",
                    key = "g",
                },
                {
                    icon = "   ",
                    desc = "Config",
                    group = "Number",
                    action = function()
                        local config_dir = vim.fn.stdpath("config")
                        vim.loop.chdir(config_dir)

                        local fzf = require("fzf-lua")
                        fzf.files({ cwd = config_dir })
                    end,
                    key = "c",
                },
                {
                    icon = "  󰗼 ",
                    desc = "Quit",
                    group = "@conditional",
                    action = "qa",
                    key = "q",
                },
            },
        },
    },
}
