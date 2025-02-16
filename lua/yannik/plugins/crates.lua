return {
	{
		"saecki/crates.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		event = { "BufRead Cargo.toml" },
		opts = {
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
		},
		config = true,
	},
}
