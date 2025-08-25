local new_capability = {
    -- this will remove some of the diagnostics that duplicates those from ruff, idea taken and adapted from
    -- here: https://github.com/astral-sh/ruff-lsp/issues/384#issuecomment-1989619482
    textDocument = {
        publishDiagnostics = {
            tagSupport = {
                valueSet = { 2 },
            },
        },
        hover = {
            contentFormat = { "plaintext" },
            dynamicRegistration = true,
        },
    },
}

return {
    cmd = { "basedpyright-langserver", "--stdio" },
    settings = {
        basedpyright = {
            disableOrganizeImports = true,
            disableTaggedHints = true,
            analysis = {
                -- diagnosticMode = "openFilesOnly",
                diagnosticMode = "workspace",
                typeCheckingMode = "standard",
                autoImportCompletions = true,
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                    deprecateTypingAliases = false,
                },
                inlayHints = {
                    variableTypes = true,
                    callArgumentNames = true,
                    functionReturnTypes = true,
                    pytestParameters = true,
                    genericTypes = true,
                },
            },
        },
    },
    capabilities = new_capability,
}
