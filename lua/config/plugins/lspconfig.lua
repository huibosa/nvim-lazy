return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
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

        vim.api.nvim_set_hl(0, "LspReferenceRead", { default = false, link = "Visual" })
        vim.api.nvim_set_hl(0, "LspReferenceText", { default = false, link = "Visual" })
        vim.api.nvim_set_hl(0, "LspReferenceWrite", { default = false, link = "Visual" })

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
                keymap("n", "gi", vim.lsp.buf.implementation, { desc = "LSP [implementation]" })
                keymap("n", "gt", vim.lsp.buf.type_definition, { desc = "LSP [type] definition" })
                keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP [references]" })
                keymap("n", "gs", vim.lsp.buf.signature_help, { desc = "LSP [signature]" })

                keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous [diagnostic]" })
                keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next [diagnostic]" })
                keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[Rename]" })
                keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[Code] actions" })

                keymap(
                    "n",
                    "<leader>fs",
                    "<cmd>Telescope lsp_document_symbols<CR>",
                    { desc = "LSP document [symbols]" }
                )
                keymap(
                    "n",
                    "<leader>fS",
                    "<cmd>Telescope lsp_workspace_symbols<CR>",
                    { desc = "LSP workspace [symbols]" }
                )

                keymap("n", "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "LSP [diagnostics]" })
                keymap("n", "<leader>rs", "<cmd>LspRestart<CR>", { desc = "LSP [restart]" })

                vim.api.nvim_create_autocmd("CursorHold", {
                    buffer = bufnr,
                    callback = function() vim.lsp.buf.document_highlight() end,
                })

                vim.api.nvim_create_autocmd("CursorHoldI", {
                    buffer = bufnr,
                    callback = function() vim.lsp.buf.document_highlight() end,
                })

                vim.api.nvim_create_autocmd("CursorMoved", {
                    buffer = bufnr,
                    callback = function() vim.lsp.buf.clear_references() end,
                })

                vim.api.nvim_create_autocmd("CursorMovedI", {
                    buffer = bufnr,
                    callback = function() vim.lsp.buf.clear_references() end,
                })
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
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })

        lspconfig.pyright.setup({
            on_attach = custom_attach,
        })

        lspconfig.clangd.setup({
            on_attach = custom_attach,
            filetypes = { "c", "cpp", "cc", "h", "hpp" },
            flags = {
                debounce_text_changes = 500,
            },
        })

        lspconfig.bashls.setup({})

        lspconfig.gopls.setup({
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
