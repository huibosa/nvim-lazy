return {
    'mhartington/formatter.nvim',
    event = { 'LspAttach' },
    config = function()
        local util = require('formatter.util')

        require('formatter').setup({
            logging = true,
            log_level = vim.log.levels.WARN,
            filetype = {
                lua = {
                    function()
                        return {
                            exe = 'stylua',
                            args = {
                                '--search-parent-directories',
                                '--stdin-filepath',
                                util.escape_path(util.get_current_buffer_file_path()),
                                '--',
                                '-',
                            },
                            stdin = true,
                        }
                    end,
                },
                python = {
                    require('formatter.filetypes.python').black,
                    require('formatter.filetypes.python').isort,
                },
            },
        })
    end,
}
