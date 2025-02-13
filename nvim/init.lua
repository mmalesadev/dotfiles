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
		require("plugins.neotree"),
		require("plugins.colortheme"),
		require("plugins.bufferline"),
		require("plugins.lualine"),
		require("plugins.treesitter"),
		require("plugins.telescope"),
		require("plugins.lsp"),
		require("plugins.autosession"),
		require("plugins.autocompletion"),
		require("plugins.autoformatting"),
		require("plugins.gitsigns"),
		require("plugins.alpha"),
		require("plugins.indent-blankline"),
		require("plugins.comment"),
		require("plugins.marks"),
		require("plugins.misc"),
	}
end
require("lazy").setup(plugins)
