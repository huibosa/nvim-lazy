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
                on_attach = function(_, bufnr)
                    vim.keymap.set("n", "gra", function()
                        vim.cmd.RustLsp('codeAction')
                    end, { silent = true, buf = bufnr })

                    vim.keymap.set("n", "K", function()
                        vim.cmd.RustLsp({ 'hover', 'actions' })
                    end, { silent = true, buf = bufnr })

                    vim.keymap.set("n", "<leader>rd", function()
                        vim.cmd.RustLsp('debuggables')
                    end, { silent = true, buf = bufnr, desc = "Rust debuggables" })

                    vim.keymap.set("n", "<leader>rr", function()
                        vim.cmd.RustLsp('runnables')
                    end, { silent = true, buf = bufnr, desc = "Rust runnables" })

                    vim.keymap.set("n", "<leader>rt", function()
                        vim.cmd.RustLsp('testables')
                    end, { silent = true, buf = bufnr, desc = "Rust testables" })
                end,
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
            dap = {
                autoload_configurations = true,
            },
        }
    end,
}
