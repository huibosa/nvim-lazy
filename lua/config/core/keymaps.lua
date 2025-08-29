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
keymap("x", "Y", '"+y')
keymap("n", "c*", "*Ncgn")
keymap({ "n", "x" }, "H", "^")
keymap({ "n", "x" }, "L", "$")
keymap("n", "j", "j")
keymap("n", "k", "k")
keymap("n", "J", "mzJ`z") -- Join next line without moving cursor

keymap("n", "<BS>", "<C-^>")

-- Emulate <C-a> as vscode <Home> key
vim.keymap.set({ "i", "x", "o" }, "<C-a>", "", {
    callback = utils.vscode_home_key,
    noremap = true,
    silent = true,
})

-- Map <C-k> to kill line like emacs
vim.keymap.set("i", "<C-k>", "", {
    callback = utils.kill_line,
    noremap = true,
    silent = true,
})

keymap({ "i", "x", "o" }, "<C-e>", "<END>")
keymap({ "i", "x", "o" }, "<C-b>", "<LEFT>")
keymap({ "i", "x", "o" }, "<C-f>", "<RIGHT>")
keymap("i", "<C-d>", "<DEL>")

vim.keymap.set("c", "<C-a>", "<HOME>")
vim.keymap.set("c", "<C-e>", "<END>")
vim.keymap.set("c", "<C-b>", "<LEFT>")
vim.keymap.set("c", "<C-f>", "<RIGHt>")
vim.keymap.set("c", "<C-d>", "<DEL>")
