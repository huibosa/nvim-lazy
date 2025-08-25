--Create RemoveLsplog command
vim.api.nvim_create_user_command("RemoveLsplog", function() vim.fn.writefile({}, vim.lsp.get_log_path()) end, {})
