-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-----------------------------------------------------------
-- Application Shortcuts
-----------------------------------------------------------
map('n', '<C-t>', ':NERDTreeToggle<CR>', { noremap = true}) 		-- nerdtree

-----------------------------------------------------------
-- Conquer of Completion (CoC)
-----------------------------------------------------------

-- Ctrl + space refresh
map('i', '<C-space>', 'coc#refresh()', { silent = true, expr = true}) 

-- Tab to auto-complete
map("i", "<TAB>", "coc#pum#visible() ? coc#pum#next(1) : '<TAB>'", {noremap = true, silent = true, expr = true})
map("i", "<S-TAB>", "coc#pum#visible() ? coc#pum#prev(1) : '<C-h>'", {noremap = true, expr = true})

-- <CR> to accept selected completion
map("i", "<CR>", "coc#pum#visible() ? coc#pum#confirm() : '<C-G>u<CR><C-R>=coc#on_enter()<CR>'", {silent = true, expr = true, noremap = true})
