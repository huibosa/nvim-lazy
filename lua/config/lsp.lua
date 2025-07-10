local hover = vim.lsp.buf.hover
vim.lsp.buf.hover = function()
    return hover({
        border = vim.g.window_borders,
    })
end

local signature_help = vim.lsp.buf.signature_help
vim.lsp.buf.signature_help = function()
    return signature_help({
        border = vim.g.window_borders,
    })
end
