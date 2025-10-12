local opt = vim.opt

-- Use English as main language
vim.cmd([[language en_US.UTF-8]])

opt.mouse = ""             -- disable the mouse
opt.termguicolors = true   -- enable 24bit colors

opt.updatetime = 300       -- decrease updatetime
opt.fileformat = "unix"    -- <NL> for EOL
opt.fileencoding = "utf-8" -- encoding for reading and writing files
opt.encoding = "utf-8"     -- encoding for specifying text
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }

opt.cmdheight = 1     -- cmdline height
opt.scrolloff = 5     -- min number of lines to keep between cursor and screen edge
opt.sidescrolloff = 5 -- min number of cols to keep between cursor and screen edge
opt.number = true

opt.signcolumn = "yes"
opt.numberwidth = 3
opt.statuscolumn = "%=%l%s"

-- General tab settings
opt.tabstop = 2       -- Tab indentation levels every two columns
opt.softtabstop = 2   -- Tab indentation when mixing tabs & spaces
opt.shiftwidth = 2    -- Indent/outdent by two columns
opt.shiftround = true -- Always indent/outdent to nearest tabstop
opt.expandtab = true  -- Convert all tabs that are typed into spaces

opt.swapfile = false

-- Editor behavior
-- opt.filetype = "plugin"
opt.hidden = true

opt.hlsearch = true
opt.incsearch = true

opt.inccommand = "nosplit"
opt.ignorecase = true
opt.smartcase = true
opt.wildmenu = true

opt.autoindent = true
opt.smartindent = true

opt.foldenable = true
opt.foldlevel = 99
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""
opt.foldcolumn = "0"

opt.splitright = true
opt.splitbelow = true
opt.showmode = true

-- Break line at predefined characters
opt.linebreak = true
opt.showbreak = "↪"

opt.autowrite = true
opt.undofile = true
opt.shortmess = "acosOCIF"

opt.virtualedit = "block"
opt.formatoptions:append({ m = true, M = true })

-- External program to use for grep command
if vim.fn.executable("rg") then
    opt.grepprg = "rg --vimgrep --no-heading --smart-case"
    opt.grepformat = "%f:%l:%c:%m"
end

-- Set up cursor color and shape in various modes
-- opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor20"
opt.guicursor = "i:block"

-- Remove certain characters from file name pattern matching
opt.isfname:remove({ "," })

opt.wrap = false
opt.ruler = false

opt.laststatus = 0

-- Change fillchars for folding, vertical split, end of buffer, and message separator
opt.fillchars:append({ fold = " ", vert = "┃", eob = " ", msgsep = "‾" })
opt.fillchars:append({
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    vert = "┃",
    vertleft = "┫",
    vertright = "┣",
    verthoriz = "╋",
})

-- Ignore certain files and folders when globbing
opt.wildignore:append({ "*.o", "*.obj", "*.dylib", "*.bin", "*.dll", "*.exe" })
opt.wildignore:append({ "*/.git/*", "*/.svn/*", "*/__pycache__/*", "*/build/**" })
opt.wildignore:append({ "*.jpg", "*.png", "*.jpeg", "*.bmp", "*.gif", "*.tiff", "*.svg", "*.ico" })
opt.wildignore:append({ "*.pyc", "*.pkl", "*.DS_Store" })
opt.wildignorecase = true

-- Diff options
opt.diffopt = {}
opt.diffopt:append("vertical")  -- Show diff in vertical position
opt.diffopt:append("filler")    -- Show filler for deleted lines
opt.diffopt:append("closeoff")  -- Turn off diff when one file window is closed
opt.diffopt:append("context:3") -- Context for diff
opt.diffopt:append("internal,indent-heuristic,algorithm:histogram")
