return {
	"williamboman/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})
		require("mason-tool-installer").setup({
			auto_update = true,
			ensure_installed = {
				-- Language Servers
				"bash-language-server",
				"clangd",
				"css-lsp",
				"deno",
				"docker-compose-language-service",
				"dockerfile-language-server",
				"emmet-language-server",
				"gopls",
				"html-lsp",
				"htmx-lsp",
				"jdtls",
				"lua-language-server",
				"pyright",
				"rust-analyzer",
				"tailwindcss-language-server",
				"taplo",
				"templ",
				"typescript-language-server",
				"yaml-language-server",
				-- Linter
				"biome",
				"cpplint",
				"luacheck",
				-- "mypy",
				"revive",
				"ruff",
				"shellcheck",
				"typos",
				"write-good",
				"yamllint",
				-- Formatters
				"clang-format",
				"gofumpt",
				"goimports",
				"markdown-toc",
				"prettierd",
				"shfmt",
				"stylua",
				"yamlfmt",
				--- Debuggers
				"codelldb",
				"debugpy",
				"delve",
				"java-debug-adapter",
				"java-test",
				"js-debug-adapter",
			},
		})
	end,
}
