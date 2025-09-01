local diagnostic = vim.diagnostic

-- global config for diagnostic
diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_lines = false,
    virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
    },
    severity_sort = true,
    signs = {
        text = {
            [diagnostic.severity.ERROR] = "",
            [diagnostic.severity.WARN] = "",
            [diagnostic.severity.INFO] = "",
            [diagnostic.severity.HINT] = "",
        },
        numhl = {
            [diagnostic.severity.ERROR] = "RedSign",
            [diagnostic.severity.WARN] = "YellowSign",
            [diagnostic.severity.INFO] = "BlueSign",
            [diagnostic.severity.HINT] = "GreenSign",
        },
    },
    float = {
        source = true,
        -- header = "Diagnostics:",
        -- prefix = " ",
        border = 'bold',
    },
})
