local M = {}

M.is_git_dir = function()
    local result = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null")
    if result == "true" then
        return true
    else
        return false
    end
end

return M
