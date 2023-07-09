-------------------------------
--- Matt Smith's NeoVim Config
-------------------------------

local g = vim.g     -- Global variables
local opt = vim.opt -- Set options

-------------------------------
--- General
-------------------------------

opt.mouse = 'a'      -- Enable mouse support
opt.swapfile = false -- Don't use swapfile
opt.completeopt = 'menuone,noinsert,noselect' -- Autocomplete options


-------------------------------
--- Neovim UI
-------------------------------

opt.number = true 		-- Show line number
opt.showmatch = true      	-- Highlight matching parenthesis
opt.foldmethod = 'marker' 	-- enable folding (default 'foldmarker')
opt.colorcolumn = '80'		-- Line length marker at 80 columns
opt.ignorecase = true		-- Ignore case letters when search
opt.linebreak = true		-- wrap on word boundary
opt.termguicolors = true	-- Enable 24-bit RGB colors

-------------------------------
--- Tabs, indent
-------------------------------
opt.smartindent = true		-- Audoindent new lines

-------------------------------
--- Memory, CPU
-------------------------------
opt.history = 100		-- Remember N lines in history
opt.lazyredraw = true		-- Faster scrolling
opt.updatetime = 250		-- ms to wait for trigger an event
