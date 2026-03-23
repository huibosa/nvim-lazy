return {
    on_attach = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
                local params = vim.lsp.util.make_range_params()
                params.context = { only = { "source.organizeImports" } }
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
            ["local"] = "",
            buildFlags = {},
            templateExtensions = {},
            standaloneTags = { "ignore" },
            expandWorkspaceToModule = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },

            analyses = {
                nilness = true,
                shadow = true,
                unusedwrite = true,
                useany = true,
                unusedparams = true,
                unreachable = true,
            },
            staticcheck = true,
            vulncheck = "Imports",
            annotations = {
                bounds = true,
                escape = true,
                inline = true,
                ["nil"] = true,
            },
            diagnosticsDelay = "1s",
            diagnosticsTrigger = "Edit",
            analysisProgressReporting = true,

            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },

            gofumpt = true,

            semanticTokens = true,
            newGoFileHeader = true,
            codelenses = {
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
                test = false,
                vulncheck = false,
            },

            usePlaceholders = false,
            completeFunctionCalls = true,
            experimentalPostfixCompletions = true,
            matcher = "Fuzzy",
            completeUnimported = true,
            completionBudget = "100ms",

            importShortcut = "Both",
            symbolMatcher = "FastFuzzy",
            symbolStyle = "Dynamic",
            symbolScope = "all",

            hoverKind = "FullDocumentation",
            linkTarget = "pkg.go.dev",
            linksInHover = true,
        },
    },
}
