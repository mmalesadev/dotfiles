return {
	"chentoast/marks.nvim",
	event = "VeryLazy",
	opts = { -- whether to map keybinds or not. default true
		default_mappings = true,
		-- which builtin marks to show. default {}
		builtin_marks = {},
		-- whether movements cycle back to the beginning/end of buffer. default true
		cyclic = true,
		-- whether the shada file is updated after modifying uppercase marks. default false
		force_write_shada = false,
		-- how often (in ms) to redraw signs/recompute mark positions.
		-- higher values will have better performance but may cause visual lag,
		-- while lower values may cause performance penalties. default 150.
		refresh_interval = 250,
		-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
		-- marks, and bookmarks.
		-- can be either a table with all/none of the keys, or a single number, in which case
		-- the priority applies to all marks.
		-- default 10.
		sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
		-- disables mark tracking for specific filetypes. default {}
		excluded_filetypes = {},
		-- disables mark tracking for specific buftypes. default {}
		excluded_buftypes = {},
		-- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
		-- sign/virttext. Bookmarks can be used to group together positions and quickly move
		-- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
		-- default virt_text is "".
		bookmark_0 = {
			sign = "⚑",
			virt_text = "hello world",
			-- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
			-- defaults to false.
			annotate = false,
		},
		mappings = {},
	},
	config = function(_, opts)
		require("marks").setup(opts)
		local keymap_opts = { noremap = true, silent = true }

		vim.keymap.set("n", "<C-S-1>", "mA", keymap_opts)
		vim.keymap.set("n", "<C-1>", "`A", keymap_opts)

		vim.keymap.set("n", "<C-S-2>", "mB", keymap_opts)
		vim.keymap.set("n", "<C-2>", "`B", keymap_opts)

		vim.keymap.set("n", "<C-S-3>", "mC", keymap_opts)
		vim.keymap.set("n", "<C-3>", "`C", keymap_opts)

		vim.keymap.set("n", "<C-S-4>", "mD", keymap_opts)
		vim.keymap.set("n", "<C-4>", "`D", keymap_opts)

		vim.keymap.set("n", "<C-S-5>", "mE", keymap_opts)
		vim.keymap.set("n", "<C-5>", "`E", keymap_opts)

		vim.keymap.set("n", "<C-S-6>", "mF", keymap_opts)
		vim.keymap.set("n", "<C-6>", "`F", keymap_opts)

		vim.keymap.set("n", "<C-S-7>", "mG", keymap_opts)
		vim.keymap.set("n", "<C-7>", "`G", keymap_opts)

		vim.keymap.set("n", "<C-S-8>", "mH", keymap_opts)
		vim.keymap.set("n", "<C-8>", "`H", keymap_opts)

		vim.keymap.set("n", "<C-S-9>", "mI", keymap_opts)
		vim.keymap.set("n", "<C-9>", "`I", keymap_opts)

		vim.keymap.set("n", "<C-S-0>", "mJ", keymap_opts)
		vim.keymap.set("n", "<C-0>", "`J", keymap_opts)

		vim.keymap.set("n", "<C-S-d>", function()
			local row = vim.api.nvim_win_get_cursor(0)[1] -- Get current line number (1-based)

			-- Check for marks A-J and delete the one on the current line
			for _, mark in ipairs({ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J" }) do
				local mark_pos = vim.fn.getpos("'" .. mark)
				if mark_pos[2] == row then
					vim.cmd("delmarks " .. mark) -- Delete the mark
					print("Deleted mark " .. mark .. " at line " .. row)
					return
				end
			end
		end, keymap_opts)
	end,
}
