return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lspconfig = require("lspconfig")

        -- Declare the client capabilities, which announce to the LSP server what
        -- features the editor can support. Here we merge the defaults lspconfig provides
        -- with the capabilities nvim-cmp adds.
        lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
            "force",
            lspconfig.util.default_config.capabilities,
            require("cmp_nvim_lsp").default_capabilities()
        )

        vim.lsp.handlers["textDocument/publishDiagnostics"] = function(...)
            vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                underline = true,
                update_in_insert = false,
            })(...)
            pcall(vim.diagnostic.setloclist, { open = false })
        end

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = vim.g.window_borders,
        })

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = vim.g.window_borders,
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local bufnr = ev.buf
                local keymap = function(mode, lhs, rhs, opts)
                    opts = opts or {}
                    opts.silent = true
                    opts.buffer = bufnr
                    vim.keymap.set(mode, lhs, rhs, opts)
                end

                -- keymap(
                --     "n",
                --     "<LEADER>lh",
                --     function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end
                -- )

                keymap("n", "gK", vim.lsp.buf.signature_help, { desc = "LSP Signature Help" })
                keymap("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP Signature Help" })
                keymap({ "n", "v" }, "<LEADER>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
                keymap("n", "<LEADER>cr", vim.lsp.buf.rename, { desc = "Rename Variable" })
                keymap("n", "<LEADER>cwa", vim.lsp.buf.add_workspace_folder, { desc = "Add Workspace Folder" })
                keymap("n", "<LEADER>cwr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove Workspace Folder" })
                keymap(
                    "n",
                    "<LEADER>cwl",
                    "<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                    { desc = "List Workspace Folders" }
                )
            end,
        })

        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    workspace = {
                        library = {
                            vim.env.VIMRUNTIME,
                            vim.fn.stdpath("config"),
                        },
                    },
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })

        lspconfig.pyright.setup({})

        lspconfig.rust_analyzer.setup({
            settings = {
                ["rust-analyzer"] = {
                    procMacro = { enable = true },
                    cargo = { allFeatures = true },
                    checkOnSave = {
                        allFeatures = true,
                        command = "clippy",
                        extraArgs = { "--no-deps" },
                    },
                },
            },
        })

        lspconfig.clangd.setup({
            cmd = {
                "clangd",
                "--completion-style=detailed",
                "--header-insertion=never",
            },
            filetypes = { "c", "cpp", "cc", "h", "hpp" },
            flags = {
                debounce_text_changes = 500,
            },
        })

        lspconfig.bashls.setup({})

        lspconfig.gopls.setup({
            on_attach = function()
                vim.api.nvim_create_autocmd("BufWritePre", {
                    pattern = "*.go",
                    callback = function()
                        local params = vim.lsp.util.make_range_params()
                        params.context = { only = { "source.organizeImports" } }
                        -- buf_request_sync defaults to a 1000ms timeout. Depending on your
                        -- machine and codebase, you may want longer. Add an additional
                        -- argument after params if you find that you have to write the file
                        -- twice for changes to be saved.
                        -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
                        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
                        for cid, res in pairs(result or {}) do
                            for _, r in pairs(res.result or {}) do
                                if r.edit then
                                    local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                                    vim.lsp.util.apply_workspace_edit(r.edit, enc)
                                end
                            end
                        end
                        vim.lsp.buf.format({ async = false })
                    end,
                })
            end,
            settings = {
                gopls = {
                    analyses = {
                        nilness = true,
                        shadow = true,
                        unusedparams = true,
                        unusewrites = true,
                        fieldalignment = true,
                        unusedwrite = true,
                        useany = true,
                    },
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true,
                    },
                    gofumpt = true,
                    staticcheck = true,
                    usePlaceholders = true,
                    completeUnimported = true,
                    directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                    semanticTokens = false,
                },
            },
        })
    end,
}
