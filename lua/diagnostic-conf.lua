local diagnostic = vim.diagnostic
local api = vim.api

-- global config for diagnostic
diagnostic.config({
    underline = false,
    update_in_insert = false,
    virtual_lines = false,
    virtual_text = {
        spacing = 4,
        source = "if_many",
        -- prefix = "●",
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
        header = "Diagnostics:",
        prefix = " ",
        border = vim.g.window_borders,
    },
})
