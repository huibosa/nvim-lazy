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
            disableTaggedHints = false,
            analysis = {
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "standard",
                autoImportCompletions = true,
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                -- we can this setting below to redefine some diagnostics
                diagnosticSeverityOverrides = {
                    deprecateTypingAliases = false,
                },
                -- inlay hint settings are provided by pylance?
                inlayHints = {
                    callArgumentNames = "partial",
                    functionReturnTypes = true,
                    pytestParameters = true,
                    variableTypes = true,
                },
            },
        },
    },
    capabilities = new_capability,
}
