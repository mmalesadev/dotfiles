local opts = { noremap = true, silent = true }

-- Save file without auto-formatting
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)

-- Quit file
vim.keymap.set("n", "<C-q>", "<cmd> q <CR>", opts)

-- Resize with Ctrl+Shift+arrows
vim.keymap.set("n", "<leader><Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<leader><Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<leader><Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<leader><Right>", ":vertical resize +2<CR>", opts)

-- Buffers
vim.keymap.set("n", "<A-q>", ":Bdelete<CR>", {}) -- close buffer
vim.keymap.set("n", "<C-Enter>", "<cmd> enew <CR>", opts) -- new buffer

-- Window management
vim.keymap.set("n", "<A-v>", "<C-w>s", opts)
vim.keymap.set("n", "<A-Enter>", "<C-w>v", opts)
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
vim.keymap.set("n", "<A-Left>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<A-Right>", ":wincmd l<CR>", opts)
vim.keymap.set("n", "<A-Up>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<A-Down>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<A-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<A-l>", ":wincmd l<CR>", opts)
vim.keymap.set("n", "<A-k>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<A-j>", ":wincmd j<CR>", opts)

-- Tabs
vim.keymap.set("n", "<leader>t<Enter>", ":tabnew<CR>", opts) -- open new tab
vim.keymap.set("n", "<leader>tq", ":tabclose<CR>", opts) -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts) --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts) --  go to previous tab

-- Quickfick list navigationt
vim.keymap.set("n", "]q", ":cnext<CR>", opts)
vim.keymap.set("n", "[q", ":cprev<CR>", opts)

-- Cursor history
vim.keymap.set("n", "<A-->", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<c-o>", true, false, true), "n", false)
end, opts)

vim.keymap.set("n", "<A-=>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<c-i>", true, false, true), "n", false)
end, opts)

-- Function for moving buffers to nearby windows
function MoveBuffer(direction)
	local current_buf = vim.api.nvim_get_current_buf()
	local current_win = vim.api.nvim_get_current_win()

	-- Get the previous buffer in the window before moving
	local buffers = vim.api.nvim_list_bufs()
	local prev_buf = nil

	-- Find the most recent buffer that is valid and different from the current one
	for _, buf in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(buf) and buf ~= current_buf then
			prev_buf = buf
			break
		end
	end

	-- Define window movement commands and split types based on direction
	local win_cmds = { right = "l", left = "h", up = "k", down = "j" }
	local split_cmds = { right = "vsplit", left = "vsplit", up = "split", down = "split" }

	local win_cmd = win_cmds[direction]
	local split_cmd = split_cmds[direction]

	-- Move in the specified direction
	vim.cmd("wincmd " .. win_cmd)

	-- Get the new window ID
	local target_win = vim.api.nvim_get_current_win()
	local target_buf = vim.api.nvim_win_get_buf(target_win)
	local target_buf_ft = vim.api.nvim_get_option_value("filetype", { buf = target_buf })

	-- If the target window contains Neo-tree, do nothing and return
	if target_buf_ft == "neo-tree" then
		vim.cmd("wincmd p") -- Go back to the original window
		return
	end

	-- If no window exists in that direction, create one
	if target_win == current_win then
		vim.cmd(split_cmd) -- Create a new split
		vim.cmd("wincmd " .. win_cmd) -- Move to the new window
		target_win = vim.api.nvim_get_current_win()
	end

	-- Move the buffer to the target window
	vim.api.nvim_win_set_buf(target_win, current_buf)

	-- If a previous buffer exists, switch back to it in the original window
	if prev_buf then
		vim.api.nvim_win_set_buf(current_win, prev_buf)
	end
end

-- Bind keys for moving buffers to nearby windows
vim.api.nvim_set_keymap("n", "<A-S-Right>", ":lua MoveBuffer('right')<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-S-Left>", ":lua MoveBuffer('left')<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-S-Up>", ":lua MoveBuffer('up')<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-S-Down>", ":lua MoveBuffer('down')<CR>", { noremap = true, silent = true })
