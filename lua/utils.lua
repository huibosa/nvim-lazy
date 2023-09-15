local M = {}

M.is_git_dir = function() return not vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null") end

return M
