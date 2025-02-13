-- Function for map keys to VS Code actions
local function map_key(key, command)
	vim.keymap.set("n", key, function()
		require("vscode").action(command)
	end, { noremap = true, silent = true })
end

-- Search through open tabs
map_key("<leader><leader>", "workbench.action.showAllEditors")

-- Search files
map_key("<leader>sf", "workbench.action.quickOpen")

-- Grep inside files
map_key("<leader>sg", "workbench.action.findInFiles")

-- Show commands
map_key("<leader>sc", "workbench.action.showCommands")

-- Search keymaps
map_key("<leader>sk", "workbench.action.openGlobalKeybindings")

-- Search current word
map_key("<leader>sw", "editor.action.addSelectionToNextFindMatch")

-- Search recent files
map_key("<leader>s.", "workbench.action.openRecent")

-- Fuzzy search in current buffer
map_key("<leader>/", "actions.find")

-- Grep in open files
map_key("<leader>s/", "workbench.action.findInFiles")

-- LSP Navigation Mappings
map_key("gr", "references-view.findReferences")

-- Symbol Searching
map_key("<leader>ss", "workbench.action.gotoSymbol")
map_key("<leader>ws", "workbench.action.showAllSymbols")

-- Rename & Code Actions
map_key("<leader>rn", "editor.action.rename")
map_key("<leader>ca", "editor.action.quickFix")

-- Diagnostics
map_key("<leader>sd", "workbench.action.problems.focus")
