vim.g.mapleader = " "
vim.g.maplocalleader = " "
local opts = { noremap = true, silent = true }
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Save
vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd> w <CR>", opts)

-- Delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode when indenting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Move text up and down
vim.keymap.set("v", "<S-Down>", ":m .+1<CR>==", opts)
vim.keymap.set("v", "<S-Up>", ":m .-2<CR>==", opts)
vim.keymap.set("v", "<S-j>", ":m .+1<CR>==", opts)
vim.keymap.set("v", "<S-k>", ":m .-2<CR>==", opts)
vim.keymap.set("x", "<S-Down>", ":move '>+1<CR>gv-gv", opts)
vim.keymap.set("x", "<S-Up>", ":move '<-2<CR>gv-gv", opts)
vim.keymap.set("x", "<S-j>", ":move '>+1<CR>gv-gv", opts)
vim.keymap.set("x", "<S-k>", ":move '<-2<CR>gv-gv", opts)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
