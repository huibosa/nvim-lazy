--Create RemoveLsplog command
vim.api.nvim_create_user_command("RemoveLsplog", function() vim.fn.writefile({}, vim.lsp.log.get_filename()) end, {})
