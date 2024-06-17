return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer", -- source for text in buffer
        "hrsh7th/cmp-path", -- source for file system paths
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip", -- for autocompletion
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            window = {
                completion = { border = "none", scrollbar = true },
                documentation = { border = vim.g.window_borders, scrollbar = true },
            },
            completion = {
                completeopt = "menu,menuone,preview",
            },
            preselect = {
                cmp.PreselectMode.None,
            },
            snippet = { -- configure how nvim-cmp interacts with snippet engine
                expand = function(args) luasnip.lsp_expand(args.body) end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-u>"] = cmp.mapping.scroll_docs(-1),
                ["<C-d>"] = cmp.mapping.scroll_docs(1),
                ["<C-SPACE>"] = cmp.mapping.complete(), -- show completion suggestions
                ["<C-e>"] = cmp.mapping.abort(), -- close completion window
                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ["<TAB>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-TAB>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- snippets
                { name = "path" }, -- file system paths
                { name = "buffer" }, -- text within current buffer
            }),
            formatting = {
                fields = { "abbr", "kind", "menu" },
                format = function(entry, item)
                    local short_name = {
                        nvim_lsp = "LSP",
                        luasnip = "SNIP",
                        path = "PATH",
                        buffer = "BUFR",
                    }

                    local menu_name = short_name[entry.source.name] or entry.source.name

                    item.menu = string.format("[%s]", menu_name)
                    return item
                end,
            },
        })
    end,
}
