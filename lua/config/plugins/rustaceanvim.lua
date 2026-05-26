return {
    'mrcjkb/rustaceanvim',
    version = '^9',
    lazy = false,
    init = function()
        vim.g.rustaceanvim = {
            tools = {
                float_win_config = {
                    border = 'bold',
                },
            },
            server = {
                settings = {
                    ['rust-analyzer'] = {
                        cargo = {
                            allFeatures = true,
                            loadOutDirsFromCheck = true,
                            buildScripts = { enable = true },
                        },
                        checkOnSave = true,
                        check = { command = 'clippy' },
                        procMacro = { enable = true },
                        files = { watcher = 'client' },
                    },
                },
            },
        }
    end,
}
