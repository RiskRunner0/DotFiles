vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "Q", "<nop>")

-- Quickfix and location list navigation
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })
vim.keymap.set("n", "]l", "<cmd>lnext<CR>zz", { desc = "Next location item" })
vim.keymap.set("n", "[l", "<cmd>lprev<CR>zz", { desc = "Previous location item" })

-- Diagnostic navigation
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Set location list" })

-- Window navigation
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", { desc = "Move to window above" })
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", { desc = "Move to window below" })
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", { desc = "Move to window left" })
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", { desc = "Move to window right" })

-- Format buffer
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format document" })
