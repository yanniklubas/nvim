return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>lf",
			function()
				require("conform").format({ timeout_ms = 600, lsp_fallback = true })
			end,
			mode = { "n", "v" },
			desc = "[L]SP [F]ormat file",
		},
		{
			"<leader>lfdb",
			"<CMD>FormatDisable!<CR>",
			mode = "n",
			desc = "[D]isable [L]SP [F]ormat for the current [B]uffer",
		},
		{
			"<leader>lfdg",
			"<CMD>FormatDisable<CR>",
			mode = "n",
			desc = "[D]isable [L]SP [F]ormat [G]lobally",
		},
		{
			"<leader>le",
			"<CMD>FormatEnable<CR>",
			mode = "n",
			desc = "[E]nable [L]SP format",
		},
	},
	opts = {
		formatters_by_ft = {
			c = { "clang-format" },
			cpp = { "clang-format" },
			css = { "prettierd" },
			go = { "gofumpt", "goimports", "gofmt" },
			html = { "prettierd" },
			javascript = { "biome" },
			javascriptreact = { "biome" },
			lua = { "stylua" },
			markdown = { "prettierd", "markdown-toc" },
			python = { "ruff_format" },
			rust = { "rustfmt" },
			sh = { "shfmt" },
			toml = { "taplo" },
			typescript = { "biome" },
			typescriptreact = { "biome" },
			yaml = { "yamlfmt" },
			["*"] = { "trim_whitespace" },
		},
		format_on_save = function(bufnr)
			-- Disable with a global or buffer-local variable
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { lsp_format = "fallback" }
		end,
	},
	init = function()
		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- FormatDisable! will disable formatting just for this buffer
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})
		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})
	end,
}
