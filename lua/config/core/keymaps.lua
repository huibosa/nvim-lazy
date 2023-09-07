-- Disable Space key (map it to Nop)
vim.api.nvim_set_keymap("n", "<Space>", "<Nop>", { noremap = true, silent = true })

-- Set mapleader to Space
vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })
vim.api.nvim_set_keymap("x", "Y", '"+y', { noremap = true })

vim.api.nvim_set_keymap("n", "Q", ":q!<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<", "<<", { noremap = true })
vim.api.nvim_set_keymap("n", ">", ">>", { noremap = true })

vim.api.nvim_set_keymap("n", "c*", "*Ncgn", { noremap = true })

vim.api.nvim_set_keymap("n", "H", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "L", "$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "H", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "L", "$", { noremap = true, silent = true })

-- Keeping j and k silent in normal mode
vim.api.nvim_set_keymap("n", "j", "j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "k", "k", { noremap = true, silent = true })

-- Resize mappings
vim.api.nvim_set_keymap("n", "<Up>", ":res +5<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Down>", ":res -5<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Left>", ":vertical resize-5<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Right>", ":vertical resize+5<CR>", { noremap = true })

-- Emulate <C-a> as vscode <Home> key
vim.api.nvim_set_keymap("i", "<C-a>", "", {
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
vim.api.nvim_set_keymap("i", "<C-k>", "", {
	callback = function()
		local current_line = vim.fn.getline(".")
		local cursor_col = vim.fn.col(".")
		local line_length = #current_line

		-- Check if there are characters to delete after the cursor
		if cursor_col <= line_length then
			-- Delete the characters
			vim.fn.setline(vim.fn.line("."), current_line:sub(1, cursor_col - 1))

			-- Move the cursor to the end of the modified text
			vim.fn.cursor(vim.fn.line("."), cursor_col)
		end
	end,
})

vim.api.nvim_set_keymap("i", "<C-e>", "<End>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-b>", "<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-f>", "<Right>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-d>", "<Del>", { noremap = true })

-- Command-line mappings
vim.api.nvim_set_keymap("c", "<C-a>", "<Home>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-e>", "<End>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-b>", "<Left>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-f>", "<Right>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-d>", "<Del>", { noremap = true })

-- Buffer navigation mappings
vim.api.nvim_set_keymap("n", "]b", ":bnext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "[b", ":bprev<CR>", { noremap = true })

-- Delete buffer without closing split
vim.api.nvim_set_keymap("n", "<leader>d", ":bp<Bar>bd #<CR>", { noremap = true, silent = true })
