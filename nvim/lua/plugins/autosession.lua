return {
	"rmagatti/auto-session",
	lazy = false,

	opts = {
		suppressed_dirs = { "~/", "~/projects", "~/Downloads", "/" },
		-- log_level = 'debug',
		post_restore_cmds = {
			function()
				local reveal_file = vim.fn.expand("%:p")
				if reveal_file == "" then
					reveal_file = vim.fn.getcwd()
				end

				require("neo-tree.command").execute({
					action = "show",
					source = "filesystem",
					position = "left",
					reveal_file = reveal_file,
					reveal_force_cwd = true,
				})
			end,
		},
		no_restore_cmds = {
			function()
				local reveal_file = vim.fn.expand("%:p")
				if reveal_file == "" then
					reveal_file = vim.fn.getcwd()
				end

				require("neo-tree.command").execute({
					action = "show",
					source = "filesystem",
					position = "left",
					reveal_file = reveal_file,
					reveal_force_cwd = true,
				})
			end,
		},
	},
}
