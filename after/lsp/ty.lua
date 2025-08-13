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
    cmd = { "ty", "server" },
    settings = {
    },
    capabilities = new_capability,
}
