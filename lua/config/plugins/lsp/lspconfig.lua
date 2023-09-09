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
      map("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references" })
      map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
      map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show LSP definitions" })
      map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Show LSP implementations" })

      map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Show LSP type definitions" })

      map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Show LSP document symbols" })
      map("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "Show LSP workspace symbols" })

      map("n", "<leader>fD", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics" })
      map("n", "<leader>fd", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

      map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
      map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

      map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "See available code actions" })
      map("n", "K", vim.lsp.buf.hover, { desc = "Show documentation for what is under cursor" })
      map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })
      map("n", "<leader>rs", "<cmd>LspRestart<CR>", { desc = "Restart LSP" })

      -- Set some key bindings conditional on server capabilities
      if client.server_capabilities.documentFormattingProvider then
        map("n", "==", vim.lsp.buf.format, { desc = "format code" })
      end

      vim.cmd([[
        hi! link LspReferenceRead Visual
        hi! link LspReferenceText Visual
        hi! link LspReferenceWrite Visual
      ]])

      vim.api.nvim_create_autocmd("CursorHold", {
        pattern = "*",
        callback = function()
          vim.lsp.buf.document_highlight()
        end
      })

      vim.api.nvim_create_autocmd("CursorHoldI", {
        pattern = "*",
        callback = function()
          vim.lsp.buf.document_highlight()
        end
      })

      vim.api.nvim_create_autocmd("CursorMoved", {
        pattern = "*",
        callback = function()
          vim.lsp.buf.clear_references()
        end
      })

      vim.api.nvim_create_autocmd("CursorMovedI", {
        pattern = "*",
        callback = function()
          vim.lsp.buf.clear_references()
        end
      })
    end

    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    --   vim.lsp.handlers.hover, {
    --     border = vim.g.window_borders
    --   }
    -- )
    --
    -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    --   vim.lsp.handlers.signature_help, {
    --     border = vim.g.window_borders
    --   }
    -- )

    vim.diagnostic.config {
      float = { border = vim.g.window_borders }
    }

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
