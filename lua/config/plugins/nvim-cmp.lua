return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer", -- source for text in buffer
        "hrsh7th/cmp-path", -- source for file system paths
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua", -- source for nvim lua completetion
        "saadparwaiz1/cmp_luasnip", -- for autocompletion
        "L3MON4D3/LuaSnip", -- snippet engine
        "rafamadriz/friendly-snippets", -- useful snippets
        "hrsh7th/cmp-nvim-lsp-signature-help",
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
                expand = function(args) luasnip.lsp_expand(args.body) end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                ["<C-e>"] = cmp.mapping.abort(), -- close completion window
                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

                ["<Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "nvim_lua", priority = 1000 },
                { name = "luasnip" }, -- snippets
                { name = "path" }, -- file system paths
                { name = "buffer" }, -- text within current buffer
                { name = "nvim_lsp_signature_help" },
            }),

            formatting = {
                fields = { "abbr", "kind", "menu" },
                format = function(entry, item)
                    local short_name = {
                        nvim_lsp = "LSP",
                        nvim_lua = "LUA",
                        luasnip = "SNIP",
                        path = "PATH",
                        buffer = "BUFR",
                        nvim_lsp_signature_help = "SIGR",
                    }

                    local menu_name = short_name[entry.source.name] or entry.source.name

                    item.menu = string.format("[%s]", menu_name)
                    return item
                end,
            },
        })
    end,
}
