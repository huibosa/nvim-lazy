local keymap = function(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("force", {
        noremap = true,
        silent = true,
    }, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Disable Space key (map it to Nop)
keymap("n", "<SPACE>", "<NOP>")

keymap("n", "Y", "y$")
keymap("x", "Y", '"+y')

keymap("n", "c*", "*Ncgn")

keymap({ "n", "x" }, "H", "^")
keymap({ "n", "x" }, "L", "$")

keymap("n", "j", "j")
keymap("n", "k", "k")

-- Moving highlighted line in visual mode
keymap("v", "K", ":m '<-2<CR>gv=gv")
keymap("v", "J", ":m '>+1<CR>gv=gv")

-- Join next line without moving cursor
keymap("n", "J", "mzJ`z")

-- Emulate <C-a> as vscode <Home> key
vim.keymap.set("i", "<C-a>", "", {
    callback = function()
        local current_line = vim.fn.getline(".")
        local non_blank_column = string.find(current_line, "%S") or 1

        local start_col = vim.fn.col(".")
        vim.fn.cursor(current_line, non_blank_column)

        if vim.fn.col(".") == start_col then vim.fn.cursor(current_line, 1) end
    end,
    noremap = true,
    silent = true,
})

-- Map <C-k> to kill line like emacs
vim.keymap.set("i", "<C-k>", "", {
    callback = function()
        local linenr = vim.fn.line(".")
        local colnr = vim.fn.col(".")
        local current_line = vim.fn.getline(".")
        local str_before_cursor = current_line:sub(1, colnr - 1)

        if colnr == #current_line + 1 then
            vim.cmd([[normal! gJ]])
        else
            vim.fn.setline(linenr, str_before_cursor)
        end
    end,
    noremap = true,
    silent = true,
})

keymap({ "i", "x", "o" }, "<C-e>", "<END>")
keymap({ "i", "x", "o" }, "<C-b>", "<LEFT>")
keymap("i", "<C-f>", "<RIGHT>")
keymap("i", "<C-d>", "<DEL>")

vim.keymap.set("c", "<C-a>", "<HOME>")
vim.keymap.set("c", "<C-e>", "<END>")
vim.keymap.set("c", "<C-b>", "<LEFT>")
vim.keymap.set("c", "<C-f>", "<RIGHt>")
vim.keymap.set("c", "<C-d>", "<DEL>")
