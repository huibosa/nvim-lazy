vim.lsp.config("jsonls", {
    filetypes = { "json", "jsonc" },
    settings = {
        json = {
            validate = { enable = true },
        },
    },
})

local hover = vim.lsp.buf.hover
vim.lsp.buf.hover = function()
    return hover({ border = 'bold' })
end

local signature_help = vim.lsp.buf.signature_help
vim.lsp.buf.signature_help = function()
    return signature_help({ border = 'bold' })
end
