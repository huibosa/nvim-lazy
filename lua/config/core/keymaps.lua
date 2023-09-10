-- Disable Space key (map it to Nop)
vim.keymap.set("n", "<Space>", "<Nop>", { noremap = true, silent = true })

vim.keymap.set("n", "Y", "y$", { noremap = true })
vim.keymap.set("x", "Y", '"+y', { noremap = true })

vim.keymap.set("n", "Q", ":q!<CR>", { noremap = true })

-- vim.keymap.set("n", "<", "<<", { noremap = true })
-- vim.keymap.set("n", ">", ">>", { noremap = true })

vim.keymap.set("n", "c*", "*Ncgn", { noremap = true })

vim.keymap.set({ "n", "x" }, "H", "^", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "L", "$", { noremap = true, silent = true })

-- Keeping j and k silent in normal mode
vim.keymap.set("n", "j", "j", { noremap = true, silent = true })
vim.keymap.set("n", "k", "k", { noremap = true, silent = true })

-- Moving hilighted lines in visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

vim.keymap.set("n", "J", "mzJ`z") -- Join next line without moving cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Emulate <C-a> as vscode <Home> key
vim.keymap.set("i", "<C-a>", "", {
  callback = function()
    local current_line = vim.fn.getline(".")
    local non_blank_column = string.find(current_line, "%S") or 1

    local start_col = vim.fn.col(".")
    vim.fn.cursor(current_line, non_blank_column)

    if vim.fn.col(".") == start_col then
      vim.fn.cursor(current_line, 1)
    end
  end,
  noremap = true,
  silent = true,
})

-- Map <C-k> to kill line like emacs
vim.keymap.set("i", "<C-k>", "", {
  callback = function()
    local linenr = vim.fn.line('.')
    local colnr = vim.fn.col('.')
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

vim.keymap.set("i", "<C-e>", "<End>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-b>", "<Left>", { noremap = true })
vim.keymap.set("i", "<C-f>", "<Right>", { noremap = true })
vim.keymap.set("i", "<C-d>", "<Del>", { noremap = true })

-- Command-line mappings
vim.keymap.set("c", "<C-a>", "<Home>", { noremap = true })
vim.keymap.set("c", "<C-e>", "<End>", { noremap = true })
vim.keymap.set("c", "<C-b>", "<Left>", { noremap = true })
vim.keymap.set("c", "<C-f>", "<Right>", { noremap = true })
vim.keymap.set("c", "<C-d>", "<Del>", { noremap = true })

-- Buffer navigation mappings
vim.keymap.set("n", "]b", ":bnext<CR>", { noremap = true })
vim.keymap.set("n", "[b", ":bprev<CR>", { noremap = true })
