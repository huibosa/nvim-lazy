return {
    settings = {
        vtsls = {
            -- Use the TypeScript installed in the workspace over the bundled one
            autoUseWorkspaceTsdk = true,
            enableMoveToFileCodeAction = true,
            experimental = {
                completion = {
                    -- Filter completion entries server-side; keeps blink.cmp snappy on big projects
                    enableServerSideFuzzyMatch = true,
                },
            },
        },
        typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            inlayHints = {
                parameterNames = { enabled = "literals" },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
            },
        },
    },
}
