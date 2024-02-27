local winbar = require("yannik.core.winbar")
local keymap = vim.keymap.set
local augroup = vim.api.nvim_create_augroup
local aucmd = vim.api.nvim_create_autocmd

aucmd({ "BufWinEnter", "BufFilePost", "BufWritePost", "InsertEnter" }, {
	group = augroup("WinBar", { clear = true }),
	callback = function()
		winbar.show_winbar()
	end,
})

aucmd("FileType", {
	group = augroup("KeyNetrw", { clear = true }),
	pattern = "netrw",
	desc = "Better mappings for netrw",
	callback = function()
		local opts = { remap = true, buffer = true }
		-- edit new file
		keymap("n", "n", "%", opts)
	end,
})

aucmd("TextYankPost", {
	group = augroup("HighlighYank", {}),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})
