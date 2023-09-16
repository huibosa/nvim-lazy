return {
    "mhartington/formatter.nvim",
    event = { "LspAttach" },
    config = function()
        local util = require("formatter.util")

        require("formatter").setup({
            logging = true,
            log_level = vim.log.levels.WARN,
            filetype = {
                lua = {
                    function()
                        return {
                            exe = "stylua",
                            args = {
                                "--search-parent-directories",
                                "--stdin-filepath",
                                util.escape_path(util.get_current_buffer_file_path()),
                                "--",
                                "-",
                            },
                            stdin = true,
                        }
                    end,
                },
                python = {
                    require("formatter.filetypes.python").black,
                    require("formatter.filetypes.python").isort,
                },
                c = {
                    require("formatter.filetypes.c").clangformat,
                },
                cpp = {
                    require("formatter.filetypes.cpp").clangformat,
                },
                sh = {
                    require("formatter.filetypes.sh").shfmt,
                    function()
                        local shiftwidth = vim.opt.shiftwidth:get()
                        local expandtab = vim.opt.expandtab:get()

                        if not expandtab then shiftwidth = 0 end

                        return {
                            exe = "shfmt",
                            args = {
                                "-i",
                                shiftwidth,
                                "--space-redirects",
                            },
                            stdin = true,
                        }
                    end,
                },
            },
        })
    end,
}
