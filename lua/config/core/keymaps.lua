local utils = require("utils")
local keymap = function(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("force", {
        noremap = true,
        silent = true,
    }, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Disable Space key (map it to Nop)
keymap({ "n", "v" }, "<SPACE>", "<NOP>")
-- keymap("x", "Y", '"+y')
-- keymap({ "n", "x" }, "H", "^")
-- keymap({ "n", "x" }, "L", "$")
keymap("n", "j", "j")
keymap("n", "k", "k")
keymap("n", "J", "mzJ`z") -- Join next line without moving cursor

keymap("n", "<BS>", "<C-^>")

-- Smart <C-a> behavior
vim.keymap.set({ "i", "x", "o" }, "<C-a>", "", {
    callback = utils.smart_c_a,
    noremap = true,
    silent = true,
})

vim.keymap.set({ "i", "x", "o" }, "<C-e>", "", {
    callback = utils.smart_c_e,
    noremap = true,
    silent = true,
})

-- Map <C-k> to kill line like emacs
vim.keymap.set("i", "<C-k>", "", {
    callback = utils.kill_line,
    noremap = true,
    silent = true,
})

keymap({ "x", "o" }, "<C-b>", "<LEFT>")
keymap({ "x", "o" }, "<C-f>", "<RIGHT>")

-- <C-f>/<C-b> in insert mode: move one char, wrapping across line boundaries
vim.keymap.set("i", "<C-f>", function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    if col >= #line then
        if row < vim.api.nvim_buf_line_count(0) then
            vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
        end
    else
        vim.api.nvim_win_set_cursor(0, { row, col + 1 })
    end
end, { noremap = true, silent = true })

vim.keymap.set("i", "<C-b>", function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    if col == 0 then
        if row > 1 then
            local prev = vim.api.nvim_buf_get_lines(0, row - 2, row - 1, false)[1]
            vim.api.nvim_win_set_cursor(0, { row - 1, #prev })
        end
    else
        vim.api.nvim_win_set_cursor(0, { row, col - 1 })
    end
end, { noremap = true, silent = true })
keymap("i", "<C-d>", "<DEL>")

-- Undo in insert mode (Ctrl+/ and Ctrl+_ send the same byte in most terminals)
keymap("i", "<C-_>", "<C-o>u", { desc = "Undo in insert mode" })
keymap("i", "<C-/>", "<C-o>u", { desc = "Undo in insert mode" })

vim.keymap.set("c", "<C-a>", "<HOME>")
vim.keymap.set("c", "<C-e>", "<END>")
vim.keymap.set("c", "<C-b>", "<LEFT>")
vim.keymap.set("c", "<C-f>", "<RIGHt>")
vim.keymap.set("c", "<C-d>", "<DEL>")
vim.keymap.set("c", "<C-k>", [[<C-\>estrpart(getcmdline(), 0, getcmdpos()-1)<CR>]])
