return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",           -- source for text in buffer
    "hrsh7th/cmp-path",             -- source for file system paths
    "L3MON4D3/LuaSnip",             -- snippet engine
    "hrsh7th/cmp-nvim-lua",         -- source for nvim lua completetion
    "saadparwaiz1/cmp_luasnip",     -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      window = {
        completion = { border = "none", scrollbar = true },
        documentation = { border = vim.g.window_borders, scrollbar = true },
      },

      completion = {
        completeopt = "menu,menuone,preview",
      },

      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),            -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(),                   -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" },  -- text within current buffer
        { name = "path" },    -- file system paths
      }),

      -- configure lspkind for vs-code like pictograms in completion menu
      -- formatting = {
      --   format = lspkind.cmp_format({
      --     mode = "text",
      --     maxwidth = 50,
      --     ellipsis_char = "...",
      --     menu = {
      --     },
      --   }),
      -- },

      formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = function(entry, item)
          local short_name = {
            nvim_lsp = "LSP",
            nvim_lua = "NvimLua",
            luasnip = "LuaSnip",
            path = "Path",
            buffer = "Buffer",
          }

          local menu_name = short_name[entry.source.name] or entry.source.name

          item.menu = string.format('[%s]', menu_name)
          return item
        end,
      }
    })
  end,
}
