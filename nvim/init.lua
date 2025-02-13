require("core.options")
require("core.keymaps")

if vim.g.vscode then
	require("core.keymaps-vscode")
else
	require("core.keymaps-neovim")
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {}

if vim.g.vscode then
	plugins = {
		require("plugins.marks"),
	}
else
	plugins = {
		-- Start screen
		require("plugins.alpha"),
		-- File tree
		require("plugins.neotree"),
		-- Current color theme
		require("plugins.colortheme"),
		-- Upper line with buffers
		require("plugins.bufferline"),
		-- Bottom line
		require("plugins.lualine"),
		-- Parser
		require("plugins.treesitter"),
		-- Telescope
		require("plugins.telescope"),
		-- Language Server Protocol
		require("plugins.lsp"),
		-- Restore sessions
		require("plugins.autosession"),
		-- Autocomplete
		require("plugins.autocompletion"),
		-- Autoformatting
		require("plugins.autoformatting"),
		-- Git related things
		require("plugins.gitsigns"),
		-- Automatic indentation
		require("plugins.indent-blankline"),
		-- Commenting code
		require("plugins.comment"),
		-- For setting marks
		require("plugins.marks"),
		-- An addon for training using VIM motions the correct way
		require("plugins.hardtime"),
		-- Miscellaneous
		require("plugins.misc"),
	}
end
require("lazy").setup(plugins)
