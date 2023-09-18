return {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local dashboard = require("dashboard")
        dashboard.setup({
            theme = "hyper",
            shortcut_type = "letter",
            config = {
                shortcut = {
                    {
                        icon = " ",
                        desc = "New",
                        group = "@character",
                        action = "enew",
                        key = "n",
                    },
                    {
                        icon = "   ",
                        desc = "File",
                        group = "Label",
                        action = "Telescope find_files",
                        key = "f",
                    },
                    {
                        icon = "   ",
                        desc = "Grep",
                        group = "@property",
                        action = "Telescope live_grep",
                        key = "g",
                    },
                    {
                        icon = "   ",
                        desc = "Conf",
                        group = "Number",
                        action = function()
                            local config_dir = vim.fn.stdpath("config")
                            vim.loop.chdir(config_dir)

                            local telescope = require("telescope.builtin")
                            telescope.find_files({
                                cwd = config_dir,
                            })
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
                disable_move = true,
                week_header = { enable = true },
                packages = { enable = true },
                project = { enable = true, limit = 5 },
                mru = { limit = 5 },
                footer = { "", "🚀 Practice, practice, practice" },
            },
        })
    end,
}
