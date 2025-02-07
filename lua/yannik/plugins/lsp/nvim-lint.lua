return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{
			"<leader>ll",
			function()
				require("lint").try_lint()
			end,
			mode = "n",
			desc = "[L]SP [L]int the current file",
		},
	},
	config = function()
		require("lint").linters_by_ft = {
			c = { "cpplint" },
			cpp = { "cpplint" },
			go = { "revive" },
			javascript = { "biomejs" },
			javascriptreact = { "biomejs" },
			lua = { "luacheck" },
			markdown = { "write_good" },
			python = { "ruff" },
			sh = { "shellcheck" },
			typescript = { "biomejs" },
			typescriptreact = { "biomejs" },
			yaml = { "yamllint" },
		}

		local group = vim.api.nvim_create_augroup("__lint__", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = group,
			callback = function()
				require("lint").try_lint("typos")
				require("lint").try_lint()
			end,
		})
	end,
	init = function()
		require("lint.linters.luacheck").args = {
			"--formatter",
			"plain",
			"--codes",
			"--ranges",
			"--globals",
			'{ "vim" }',
			"-",
		}
		require("lint.linters.yamllint").args = {
			"-d",
			'"{extends: default, rules: { document-start: {present: false}}}"',
			"--format",
			"parsable",
			"-",
		}
	end,
}
