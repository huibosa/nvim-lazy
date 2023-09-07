return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local on_attach = function(client, bufnr)
			-- Mappings.
			local map = function(mode, l, r, opts)
				opts = opts or {}
				opts.silent = true
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- set keybinds
			map("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references" })
			map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
			map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show LSP definitions" }) -- show lsp definitions
			map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Show LSP implementations" })
			map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Show LSP type definitions" })
			map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "See available code actions" })
			map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })
			map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics" })
			map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
			map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
			map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
			map("n", "K", vim.lsp.buf.hover, { desc = "Show documentation for what is under cursor" })
			map("n", "<leader>rs", "<cmd>LspRestart<CR>", { desc = "Restart LSP" })

			-- Set some key bindings conditional on server capabilities
			if client.server_capabilities.documentFormattingProvider then
				map("n", "==", vim.lsp.buf.format, { desc = "format code" })
			end

			vim.api.nvim_create_autocmd("CursorHold", {
				buffer = bufnr,
				callback = function()
					local float_opts = {
						focusable = false,
						close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
						border = "rounded",
						source = "always", -- show source in diagnostic popup window
						prefix = " ",
					}

					if not vim.b.diagnostics_pos then
						vim.b.diagnostics_pos = { nil, nil }
					end

					local cursor_pos = vim.api.nvim_win_get_cursor(0)
					if
						(cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
						and #vim.diagnostic.get() > 0
					then
						vim.diagnostic.open_float(nil, float_opts)
					end

					vim.b.diagnostics_pos = cursor_pos
				end,
			})

			-- The blow command will highlight the current variable and its usages in the buffer.
			if client.server_capabilities.documentHighlightProvider then
				vim.cmd([[
      hi! link LspReferenceRead Visual
      hi! link LspReferenceText Visual
      hi! link LspReferenceWrite Visual
    ]])

				local gid = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
				vim.api.nvim_create_autocmd("CursorHold", {
					group = gid,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.document_highlight()
					end,
				})

				vim.api.nvim_create_autocmd("CursorMoved", {
					group = gid,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.clear_references()
					end,
				})
			end
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = "", Warn = "", Hint = "", Info = "" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- configure python server
		lspconfig["pyright"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["clangd"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "c", "cpp", "cc", "h", "hpp" },
			flags = {
				debounce_text_changes = 500,
			},
		})

		lspconfig["bashls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig["gopls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
	end,
}
