return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
		require("which-key").register({
			["<leader>o"] = { name = "+Obsidian" },
		}, {})
	end,
	opts = {},
}
