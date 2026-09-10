return {
    'saghen/blink.cmp',
    event = "InsertEnter",
    dependencies = {
        "onsails/lspkind.nvim",
        {
            'mgalliou/blink-cmp-tmux',
            config = function()
                -- capture-pane without -S always returns the live screen, so a
                -- sibling pane sitting in copy mode scrolled back contributes none
                -- of the text it displays. Capture the copy-mode viewport instead.
                local tmux = require('blink-cmp-tmux')
                local orig = tmux.get_pane_content
                function tmux:get_pane_content(pane_id)
                    local info = vim.system({
                        'tmux', 'display-message', '-p', '-t', pane_id,
                        '#{pane_mode}|#{scroll_position}|#{pane_height}',
                    }, { text = true }):wait().stdout or ''
                    local mode, scroll_s, height_s = info:match('^([^|]*)|([^|]*)|([^|%s]*)')
                    local scroll, height = tonumber(scroll_s), tonumber(height_s)
                    if mode == 'copy-mode' and scroll and scroll > 0 and height then
                        return vim.system({
                            'tmux', 'capture-pane', '-p', '-t', pane_id, '-J',
                            '-S', '-' .. scroll, '-E', tostring(height - 1 - scroll),
                        }, { text = true }):wait().stdout or ''
                    end
                    return orig(self, pane_id)
                end
            end,
        },
    },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'enter',
            -- When the menu is visible, navigate it; otherwise move the cursor
            ['<C-n>'] = {
                function(cmp)
                    if cmp.is_visible() then return cmp.select_next() end
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Down>', true, false, true), 'n', false)
                    return true
                end,
            },
            ['<C-p>'] = {
                function(cmp)
                    if cmp.is_visible() then return cmp.select_prev() end
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Up>', true, false, true), 'n', false)
                    return true
                end,
            },
            -- Close the LSP signature/hover float first; only then the menu.
            -- Falls back to smart_c_e (EOL jump) when neither is shown.
            ['<C-e>'] = {
                function(cmp)
                    local float_win = vim.b.lsp_floating_preview
                    if float_win and vim.api.nvim_win_is_valid(float_win) then
                        vim.schedule(function()
                            if vim.api.nvim_win_is_valid(float_win) then
                                vim.api.nvim_win_close(float_win, true)
                            end
                        end)
                        return true
                    end
                    if cmp.is_visible() then return cmp.hide() end
                end,
                'fallback',
            },
        },

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
                window = { border = 'bold' }
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
            default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'tmux' },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },
                snippets = {
                    opts = {
                        search_paths = {
                            vim.fn.stdpath('config') .. '/snippets',
                            vim.uv.cwd() .. "/.vscode",
                        }
                    }
                },
                buffer = {
                    score_offset = -1000,
                },
                tmux = {
                    name = 'Tmux',
                    module = 'blink-cmp-tmux',
                    score_offset = -1000,
                    opts = {
                        -- 'window' | 'session' | 'all'
                        panes = 'window',
                        -- capture_history = false keeps suggestions to visible
                        -- pane text only (no scrollback)
                    }
                },
            },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" },

        sort = {
            priority = {
                kind = {
                    Text = -1000,
                }
            }
        },
        cmdline = {
            enabled = false,
        }
    },
    opts_extend = { "sources.default" }
}
