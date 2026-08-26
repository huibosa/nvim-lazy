return {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
        vim.o.background = "dark"
        vim.g.gruvbox_material_background = "medium"
        vim.g.gruvbox_material_better_performance = 1
        vim.g.gruvbox_material_current_word = "grey background"

        -- Extra LSP semantic-token distinctions the base theme leaves unstyled.
        -- gruvbox-material links @lsp.* back to Tree-sitter groups, so type
        -- modifiers (readonly, deprecated, ...) get no visual differentiation
        -- out of the box. Pull colors from the theme's own palette so this
        -- stays in sync with the active background/palette.
        local function lsp_overrides()
            local palette = vim.fn["gruvbox_material#get_palette"](
                vim.g.gruvbox_material_background or "medium",
                vim.g.gruvbox_material_foreground or "material",
                vim.empty_dict()
            )
            local function fg(name)
                return palette[name] and palette[name][1] or nil
            end

            local hl = vim.api.nvim_set_hl
            -- readonly / const identifiers: theme foreground (white)
            hl(0, "@lsp.typemod.variable.readonly", { fg = fg("fg0") })
            hl(0, "@lsp.typemod.property.readonly", { fg = fg("fg0") })
            hl(0, "@lsp.typemod.parameter.readonly", { fg = fg("fg0") })
            -- deprecated symbols: struck through so they're obvious at a glance
            hl(0, "@lsp.mod.deprecated", { strikethrough = true })
        end

        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "gruvbox-material",
            callback = lsp_overrides,
        })

        vim.cmd([[colorscheme gruvbox-material]])
    end,
}
