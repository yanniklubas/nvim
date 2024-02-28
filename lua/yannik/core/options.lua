local opt = vim.opt

-- Relative line numbers
opt.relativenumber = true
opt.number = true

-- Tabs & indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true -- expand tabs to spaces
opt.autoindent = true -- keep ident from previous line
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed cases in search, assume you want a case-sensitive search

-- Cursor line
opt.cursorline = true

-- opt.termguicolors = false
opt.signcolumn = "yes"

-- remove ident, end of line, and insert mode start position with backspace
opt.backspace = "indent,eol,start"

-- Swapfile
opt.swapfile = false
-- do not backup on write
opt.backup = false
-- save undofile
opt.undofile = true

opt.hlsearch = true
opt.incsearch = true

opt.scrolloff = 8

opt.colorcolumn = "120"

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 15

opt.conceallevel = 2
