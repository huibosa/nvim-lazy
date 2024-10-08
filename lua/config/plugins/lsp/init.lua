return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        diagnostics = {
            underline = false,
            update_in_insert = false,
            virtual_text = {
                spacing = 4,
                source = "if_many",
                -- prefix = "●",
            },
            severity_sort = true,
            float = {
                border = vim.g.window_borders,
                source = "always",
            },
        },
    },
    config = function(_, opts)
        local lspconfig = require("lspconfig")

        vim.fn.sign_define("DiagnosticSignError", { text = "", numhl = "RedSign" })
        vim.fn.sign_define("DiagnosticSignWarn", { text = "", numhl = "YellowSign" })
        vim.fn.sign_define("DiagnosticSignInfo", { text = "", numhl = "BlueSign" })
        vim.fn.sign_define("DiagnosticSignHint", { text = "", numhl = "GreenSign" })

        vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

        -- Declare the client capabilities, which announce to the LSP server what
        -- features the editor can support.
        lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
            "force",
            lspconfig.util.default_config.capabilities,
            require("cmp_nvim_lsp").default_capabilities()
        )

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

                keymap("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
                keymap("i", "<C-l>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
                keymap("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })
                keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration" })
                keymap("n", "gr", vim.lsp.buf.references, { desc = "References" })
                keymap("n", "gy", vim.lsp.buf.type_definition, { desc = "Type Definitions" })
                keymap("n", "gI", vim.lsp.buf.implementation, { desc = "Implementation" })
                keymap({ "n", "v" }, "<LEADER>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
                keymap("n", "<LEADER>cr", vim.lsp.buf.rename, { desc = "Rename" })
                keymap("n", "<LEADER>cwa", vim.lsp.buf.add_workspace_folder, { desc = "Add Folder" })
                keymap("n", "<LEADER>cwr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove Folder" })
                keymap(
                    "n",
                    "<LEADER>cwl",
                    "<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                    { desc = "List Folders" }
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

        lspconfig.pyright.setup({
            cmd = {
                "delance-langserver",
                "--stdio",
            },
            settings = {
                python = {
                    -- disableOrganizeImports = false,
                    pythonPath = vim.fn.exepath("python3"),
                    analysis = {
                        typeCheckingMode = "basic",
                    },
                },
            },
        })

        lspconfig.rust_analyzer.setup({
            cmd = {
                "rustup",
                "run",
                "stable",
                "rust-analyzer",
            },
            settings = {
                ["rust-analyzer"] = {
                    cargo = {
                        allFeatures = true,
                        loadOutDirsFromCheck = true,
                        runBuildScripts = true,
                    },
                    -- Add clippy lints for Rust.
                    checkOnSave = {
                        allFeatures = true,
                        command = "clippy",
                        extraArgs = {
                            "--",
                            "--no-deps",
                            "-Dclippy::correctness",
                            "-Dclippy::complexity",
                            "-Wclippy::perf",
                            "-Wclippy::pedantic",
                        },
                    },
                    procMacro = {
                        enable = true,
                        ignored = {
                            ["async-trait"] = { "async_trait" },
                            ["napi-derive"] = { "napi" },
                            ["async-recursion"] = { "async_recursion" },
                        },
                    },
                },
            },
        })

        lspconfig.clangd.setup({
            cmd = {
                "clangd",
                "--completion-style=detailed",
                "--header-insertion=never",
                "--function-arg-placeholders=1",
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
                    usePlaceholders = false,
                    completeUnimported = true,
                    directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                    semanticTokens = false,
                    -- experimentalPostfixCompletions = true,
                },
            },
        })
    end,
}
