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

        vim.fn.sign_define("DiagnosticSignError", { text = "", numhl = "RedSign" })
        vim.fn.sign_define("DiagnosticSignWarn", { text = "", numhl = "YellowSign" })
        vim.fn.sign_define("DiagnosticSignInfo", { text = "", numhl = "BlueSign" })
        vim.fn.sign_define("DiagnosticSignHint", { text = "", numhl = "GreenSign" })

        -- vim.api.nvim_set_hl(0, "LspReferenceRead", { default = false, link = "Visual" })
        -- vim.api.nvim_set_hl(0, "LspReferenceText", { default = false, link = "Visual" })
        -- vim.api.nvim_set_hl(0, "LspReferenceWrite", { default = false, link = "Visual" })
        -- vim.api.nvim_set_hl(0, "CurrentWord", { default = false, link = "Visual" })

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

                keymap("n", "K", vim.lsp.buf.hover, { desc = "LSP [documentation]" })

                keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "LSP [definitions]" })
                keymap("n", "gD", vim.lsp.buf.declaration, { desc = "LSP [declaration]" })
                -- keymap("n", "gi", vim.lsp.buf.implementation, { desc = "LSP [implementation]" })
                keymap("n", "gt", vim.lsp.buf.type_definition, { desc = "LSP [type] definition" })
                keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP [references]" })
                keymap("n", "gs", vim.lsp.buf.signature_help, { desc = "LSP [signature]" })

                keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "[Add] workspace folder" })
                keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "[Remove] workspace folder" })
                keymap(
                    "n",
                    "<leader>wl",
                    "<CMD>print(vim.inspect(vim.lsp.buf.list_workspace_folders))<CR>",
                    { desc = "[List] workspace folders" }
                )

                keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous [diagnostic]" })
                keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next [diagnostic]" })

                keymap("n", "<leader>cr", vim.lsp.buf.rename, { desc = "[Rename] variable" })
                keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code [actions]" })
            end,
        })

        local custom_attach = function(_, bufnr)
            vim.keymap.set("n", "==", ":Format<cr>", { silent = true })

            vim.api.nvim_create_autocmd("BufWritePost", {
                buffer = bufnr,
                command = ":FormatWrite",
            })
        end

        lspconfig.lua_ls.setup({
            on_attach = custom_attach,
            settings = {
                Lua = {
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
            on_attach = custom_attach,
        })

        lspconfig.erlangls.setup({
            on_attach = custom_attach,
        })

        lspconfig.elixirls.setup({
            on_attach = function()
                vim.api.nvim_create_autocmd("BufWritePre", {
                    pattern = "*.exs, *.ex",
                    callback = function() vim.lsp.buf.format({ async = true }) end,
                })
            end,
            cmd = { vim.fn.expand("~/.local/share/nvim/mason/packages/elixir-ls/language_server.sh") },
        })

        lspconfig.clangd.setup({
            on_attach = custom_attach,
            filetypes = { "c", "cpp", "cc", "h", "hpp" },
            flags = {
                debounce_text_changes = 500,
            },
        })

        lspconfig.bashls.setup({
            on_attach = custom_attach,
        })

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
