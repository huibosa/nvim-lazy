return {
    'saghen/blink.cmp',
    event = "InsertEnter",
    dependencies = { "onsails/lspkind.nvim" },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = 'enter' },

        -- keymap = {
        --     ['<C-SPACE>'] = { 'show', 'show_documentation', 'hide_documentation' },
        --     ['<C-E>'] = { 'hide', 'fallback' },
        --     ['<CR>'] = { 'accept', 'fallback' },
        --     ['<TAB>'] = { function(
        --         cmp)
        --         if cmp.snippet_active() then
        --             return cmp.accept()
        --         elseif cmp.is_ghost_text_visible() then
        --             return cmp
        --                 .accept()
        --         end
        --     end, 'snippet_forward', 'fallback' },
        --     ['<S-TAB>'] = { 'snippet_backward', 'fallback' },
        --     ['<UP>'] = { 'select_prev', 'fallback' },
        --     ['<DOWN>'] = { 'select_next', 'fallback' },
        --     ['<C-P>'] = { 'select_prev', 'fallback_to_mappings' },
        --     ['<C-N>'] = { 'select_next', 'fallback_to_mappings' },
        --     ['<C-B>'] = { 'scroll_documentation_up', 'fallback' },
        --     ['<C-F>'] = { 'scroll_documentation_down', 'fallback' },
        --     ['<C-K>'] = { 'show_signature', 'hide_signature', 'fallback' },
        -- },
        --
        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono'
        },

        completion = {
            menu = {
                auto_show = true,
                draw = {
                    gap = 2,
                    columns = {
                        { "label",     "label_description", gap = 2 },
                        { "kind_icon", "kind" },
                        -- { "source_name" },
                    },
                    components = {
                        label = {
                            text = function(item)
                                return item.label
                            end,
                        },
                        kind_icon = {
                            text = function(item)
                                local kind = require("lspkind").symbol_map[item.kind] or ""
                                return kind .. " "
                            end,
                            highlight = function(ctx)
                                local _, hl, _ = require("mini.icons").get('lsp', ctx.kind)
                                return hl
                            end
                        },
                        kind = {
                            text = function(item)
                                return item.kind
                            end,
                            highlight = function(ctx)
                                local _, hl, _ = require("mini.icons").get('lsp', ctx.kind)
                                return hl
                            end
                        },
                    },
                }
            },
            documentation = {
                auto_show = false,
                window = { border = vim.g.window_borders }
            },
            list = {
                selection = {
                    auto_insert = false,
                },
            },
            ghost_text = {
                enabled = false,
                show_with_menu = false
            }
        },

        signature = { enabled = false },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },
            },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" },
        cmdline = {
            enabled = false,
        }
    },
    opts_extend = { "sources.default" }
}
