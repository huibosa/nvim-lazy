local opt = vim.opt

opt.mouse = "" -- disable the mouse
opt.termguicolors = true -- enable 24bit colors

opt.updatetime = 300 -- decrease updatetime
opt.fileformat = "unix" -- <NL> for EOL
opt.fileencoding = "utf-8" -- encoding for reading and writing files
opt.encoding = "utf-8" -- encoding for specifying text
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }

opt.cmdheight = 1 -- cmdline height
opt.scrolloff = 10 -- min number of lines to keep between cursor and screen edge
opt.sidescrolloff = 5 -- min number of cols to keep between cursor and screen edge
opt.number = true

opt.signcolumn = "yes"
opt.numberwidth = 3
opt.stc = "%=%l%s"

-- General tab settings
opt.tabstop = 2 -- Tab indentation levels every two columns
opt.softtabstop = 2 -- Tab indentation when mixing tabs & spaces
opt.shiftwidth = 2 -- Indent/outdent by two columns
opt.shiftround = true -- Always indent/outdent to nearest tabstop
opt.expandtab = true -- Convert all tabs that are typed into spaces

opt.swapfile = false

-- Set up backup directory
vim.g.backupdir = vim.fn.expand(vim.fn.stdpath("data") .. "/backup//")
--opt.backupdir = vim.g.backupdir

-- Skip backup for patterns in option wildignore
--opt.backupskip = opt.wildignore

-- Editor behavior
opt.filetype = "plugin"
opt.hidden = true

opt.hlsearch = true
opt.incsearch = true

opt.inccommand = "nosplit"
opt.ignorecase = true
opt.smartcase = true
opt.wildmenu = true

opt.autoindent = true
opt.smartindent = true

opt.foldmethod = "syntax"
opt.foldenable = false

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
opt.diffopt:append("vertical") -- Show diff in vertical position
opt.diffopt:append("filler") -- Show filler for deleted lines
opt.diffopt:append("closeoff") -- Turn off diff when one file window is closed
opt.diffopt:append("context:3") -- Context for diff
opt.diffopt:append("internal,indent-heuristic,algorithm:histogram")

------------------------------------------------------------------------
--                         builtin variables                          --
------------------------------------------------------------------------
-- vim.g.do_filetype_lua = 1
-- vim.g.did_load_filetypes = 0

vim.g.loaded_perl_provider = 0 -- Disable perl provider
vim.g.loaded_ruby_provider = 0 -- Disable ruby provider
vim.g.loaded_node_provider = 0 -- Disable node provider
vim.g.did_install_default_menus = 1 -- do not load menu

-- Custom mapping <leader> (see `:h mapleader` for more info)
vim.g.mapleader = " "

-- Enable highlighting for lua HERE doc inside vim script
vim.g.vimsyn_embed = "l"

-- Use English as main language
vim.cmd([[language en_US.UTF-8]])

-- Disable loading certain plugins

-- Whether to load netrw by default, see https://github.com/bling/dotvim/issues/4
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_liststyle = 3

-- Do not load tohtml.vim
vim.g.loaded_2html_plugin = 1

-- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are
-- related to checking files inside compressed files)
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1

-- Do not load the tutor plugin
vim.g.loaded_tutor_mode_plugin = 1

-- Do not use builtin matchit.vim and matchparen.vim since we use vim-matchup
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1

-- Disable sql omni completion, it is broken.
vim.g.loaded_sql_completion = 1

vim.g.window_borders = {
    { "┏", "FloatBorder" },
    { "━", "FloatBorder" },
    { "┓", "FloatBorder" },
    { "┃", "FloatBorder" },
    { "┛", "FloatBorder" },
    { "━", "FloatBorder" },
    { "┗", "FloatBorder" },
    { "┃", "FloatBorder" },
}

vim.diagnostic.config({
    virtual_text = {
        spacing = 3,
        severity_sort = true,
        source = "if_many",
    },
    float = {
        border = vim.g.window_borders,
        source = "always",
    },
})
