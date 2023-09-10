return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "lukas-reineke/lsp-format.nvim"
  },
  config = function()
    local lspconfig = require("lspconfig")

    vim.api.nvim_create_autocmd('LspAttach', {
      desc = "LSP actions",
      callback = function(client, bufnr)
        local map = function(mode, l, r, opts)
          opts = opts or {}
          opts.silent = true
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", "K", vim.lsp.buf.hover, { desc = "Show documentation for what is under cursor" })
        map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show LSP definitions" })
        map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
        map("n", "gi", vim.lsp.buf.implementation, { desc = "Show LSP implementations" })
        map("n", "gt", vim.lsp.buf.type_definition, { desc = "Show LSP implementations" })
        map("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references" })
        map("n", "gs", vim.lsp.buf.signature_help, { desc = "Show function signature help" })
        map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
        map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
        map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "See available code actions" })

        map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Show LSP document symbols" })
        map("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "Show LSP workspace symbols" })

        map("n", "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics" })
        map("n", "<leader>rs", "<cmd>LspRestart<CR>", { desc = "Restart LSP" })
      end
    })

    vim.fn.sign_define("DiagnosticSignError", { text = "", numhl = "RedSign" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = "", numhl = "YellowSign" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = "", numhl = "BlueSign" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "", numhl = "GreenSign" })

    -- Declare the client capabilities, which announce to the LSP server what
    -- features the editor can support. Here we merge the defaults lspconfig provides
    -- with the capabilities nvim-cmp adds.
    lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
      'force',
      lspconfig.util.default_config.capabilities,
      require('cmp_nvim_lsp').default_capabilities()
    )

    require("lsp-format").setup {}
    local on_attach = function(client, bufnr)
      require("lsp-format").on_attach(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.notify("Fomatter supported by LSP.", vim.log.levels.INFO)
      end
    end

    lspconfig["pyright"].setup({
      on_attach = on_attach
    })

    lspconfig["bashls"].setup({
      on_attach = on_attach
    })

    lspconfig["clangd"].setup({
      on_attach = on_attach,
      filetypes = { "c", "cpp", "cc", "h", "hpp" },
      flags = {
        debounce_text_changes = 500,
      },
    })

    lspconfig["gopls"].setup({
      on_attach = on_attach,
      settings = {
        gopls = {
          usePlaceholders = true,
          analyses = {
            nilness = true,
            shadow = true,
            unusedparams = true,
            unusewrites = true,
          },
        }
      }
    })

    lspconfig["lua_ls"].setup({
      on_attach = function()
        vim.keymap.set("n", "==", vim.lsp.buf.format)
      end,
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
