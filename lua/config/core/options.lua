-- Check if in a git repo
local git_status = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null")
if git_status then
  vim.opt.signcolumn = "yes"
else
  vim.opt.signcolumn = "no"
end

-- Change fillchars for folding, vertical split, end of buffer, and message separator
vim.opt.fillchars:append({ fold = " ", vert = "│", eob = " ", msgsep = "‾" })

-- Ignore certain files and folders when globbing
vim.opt.wildignore:append({ "*.o", "*.obj", "*.dylib", "*.bin", "*.dll", "*.exe" })
vim.opt.wildignore:append({ "*/.git/*", "*/.svn/*", "*/__pycache__/*", "*/build/**" })
vim.opt.wildignore:append({ "*.jpg", "*.png", "*.jpeg", "*.bmp", "*.gif", "*.tiff", "*.svg", "*.ico" })
vim.opt.wildignore:append({ "*.pyc", "*.pkl", "*.DS_Store" })
vim.opt.wildignorecase = true

vim.opt.swapfile = false

-- Set up backup directory
vim.g.backupdir = vim.fn.expand(vim.fn.stdpath("data") .. "/backup//")
--vim.opt.backupdir = vim.g.backupdir

-- Skip backup for patterns in option wildignore
--vim.opt.backupskip = vim.opt.wildignore

-- Editor behavior
vim.opt.filetype = "plugin"
vim.opt.number = true
vim.opt.hidden = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.inccommand = "nosplit"
vim.opt.scrolloff = 5
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildmenu = true

-- General tab settings
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true

vim.opt.foldmethod = "syntax"
vim.opt.foldenable = false

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.encoding = "utf-8"
vim.opt.showmode = false
vim.opt.updatetime = 300
vim.opt.cmdheight = 0

-- Set matching pairs of characters and highlight matching brackets
vim.opt.matchpairs:append({ "「:」", "『:』", "【:】", "“:”", "‘:’", "《:》" })

vim.opt.mouse = ""

-- Break line at predefined characters
vim.opt.linebreak = true
vim.opt.showbreak = "↪"

vim.opt.autowrite = true
vim.opt.undofile = true
vim.opt.shortmess:append({ c = true, S = true, I = true })

vim.opt.shiftround = true
vim.opt.virtualedit = "block"
vim.opt.formatoptions:append({ m = true, M = true })

-- Tilde (~) is an operator
vim.opt.tildeop = true
vim.opt.synmaxcol = 250

-- External program to use for grep command
if vim.fn.executable("rg") then
  vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
  vim.opt.grepformat = "%f:%l:%c:%m"
end

vim.opt.termguicolors = true

-- Set up cursor color and shape in various modes
-- vim.opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor20"
vim.opt.guicursor = "i:block"

-- Remove certain characters from file name pattern matching
vim.opt.isfname:remove({ "-", "=" })
vim.opt.isfname:remove({ "," })

-- Diff options
vim.opt.diffopt = {}
vim.opt.diffopt:append("vertical")  -- Show diff in vertical position
vim.opt.diffopt:append("filler")    -- Show filler for deleted lines
vim.opt.diffopt:append("closeoff")  -- Turn off diff when one file window is closed
vim.opt.diffopt:append("context:3") -- Context for diff
vim.opt.diffopt:append("internal,indent-heuristic,algorithm:histogram")

vim.opt.wrap = false
vim.opt.ruler = false
