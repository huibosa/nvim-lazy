require("config.core")
require("config.lazy")

local border = {
	{ "┏", "FloatBorder" },
	{ "━", "FloatBorder" },
	{ "┓", "FloatBorder" },
	{ "┃", "FloatBorder" },
	{ "┛", "FloatBorder" },
	{ "━", "FloatBorder" },
	{ "┗", "FloatBorder" },
	{ "┃", "FloatBorder" },
}

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
