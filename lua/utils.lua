local M = {}

M.has = function(feat)
    if vim.fn.has(feat) == 1 then return true end

    return false
end

function M.executable(name) return vim.fn.executable(name) > 0 end

M.is_git_dir = function()
    local result = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null")
    if string.find(result, "true") ~= nil then
        return true
    else
        return false
    end
end

M.kill_line = function()
    local linenr = vim.fn.line(".")
    local colnr = vim.fn.col(".")
    local current_line = vim.fn.getline(".")
    local str_before_cursor = current_line:sub(1, colnr - 1)

    if colnr == #current_line + 1 then
        vim.cmd([[normal! gJ]])
    else
        vim.fn.setline(linenr, str_before_cursor)
    end
end

M.smart_c_a = function()
    local current_line = vim.fn.line(".")
    local current_col = vim.fn.col(".")

    -- Toggle between the first non-blank character and column 1
    local first_non_blank = string.find(vim.fn.getline("."), "%S") or 1
    vim.fn.cursor(current_line, first_non_blank)

    if vim.fn.col(".") ~= current_col then return end
    vim.fn.cursor(current_line, 1)
end

M.smart_c_e = function()
    -- If an LSP floating preview (signature help / hover) is displayed,
    -- close it without moving the cursor
    local float_win = vim.b.lsp_floating_preview
    if float_win and vim.api.nvim_win_is_valid(float_win) then
        vim.api.nvim_win_close(float_win, true)
        return
    end

    local current_line = vim.fn.line(".")
    local current_col = vim.fn.col(".")
    local line_length = #vim.fn.getline(".")

    -- Already past the last character (insertion point at EOL); stay put
    if current_col <= line_length then vim.fn.cursor(current_line, line_length + 1) end
end

return M
