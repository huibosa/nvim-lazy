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

M.vscode_home_key = function()
    local current_line = vim.fn.getline(".")
    local non_blank_column = string.find(current_line, "%S") or 1

    local start_col = vim.fn.col(".")
    vim.fn.cursor(current_line, non_blank_column)

    if vim.fn.col(".") == start_col then vim.fn.cursor(current_line, 1) end
end

return M
