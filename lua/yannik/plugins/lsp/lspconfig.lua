return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", config = true },
		"tpope/vim-sleuth",
	},
	config = function()
		local lspconfig = require("lspconfig")

		local keymap = vim.keymap.set
		local opts = { noremap = true, silent = true }
		opts.desc = "[E]xplain line diagnostics"
		keymap("n", "<leader>e", function()
			vim.diagnostic.open_float({ source = true })
		end, opts)
		opts.desc = "Go to [P]revious [D]iagnostic"
		keymap("n", "[d", vim.diagnostic.goto_prev, opts)
		keymap("n", "<leader>dp", vim.diagnostic.goto_prev, opts)
		opts.desc = "Go to [N]ext [D]iagnostic"
		keymap("n", "]d", vim.diagnostic.goto_next, opts)
		keymap("n", "<leader>dn", vim.diagnostic.goto_next, opts)
		opts.desc = "Add diagnostic to [Q]uickfix list"
		keymap("n", "<leader>q", vim.diagnostic.setqflist, opts)

		local on_attach = function(_client, bufnr)
			opts.buffer = bufnr

			opts.desc = "[G]o to LSP [R]eferences"
			-- keymap("n", "gR", "<CMD>Telescope lsp_references<CR>", opts)
			keymap("n", "gr", vim.lsp.buf.references, opts)

			opts.desc = "[G]o to [D]eclaration"
			keymap("n", "gD", vim.lsp.buf.declaration, opts)

			opts.desc = "[G]o to LSP [D]efinition"
			-- keymap("n", "gd", "<CMD>Telescope lsp_definitions<CR>", opts)
			keymap("n", "gd", vim.lsp.buf.definition, opts)

			opts.desc = "[G]o to LSP [I]mplementations"
			-- keymap("n", "gi", "<CMD>Telescope lsp_implementations<CR>", opts)
			keymap("n", "gi", vim.lsp.buf.implementation, opts)

			opts.desc = "Go to LSP [T]ype [D]efinitions"
			-- keymap("n", "<leader>dt", "<CMD>Telescope lsp_type_definitions<CR>", opts)
			keymap("n", "<leader>dt", vim.lsp.buf.type_definition, opts)

			opts.desc = "Show available [C]ode [A]ctions"
			keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

			opts.desc = "[R]ename symbol"
			keymap("n", "<leader>r", vim.lsp.buf.rename, opts)

			opts.desc = "Show buffer [D]iagnostics"
			keymap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

			opts.desc = "Show hover information"
			keymap("n", "K", vim.lsp.buf.hover, opts)

			opts.desc = "[R]e[S]tart the LSP server"
			keymap("n", "<leader>rs", "<CMD>LspRestart<CR>", opts)
		end

		-- used to enable autocompletion capabilities
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Change the Diagnostic symbols in the sign column
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local servers = {
			"bashls",
			"clangd",
			"cssls",
			"docker_compose_language_service",
			"dockerls",
			"emmet_language_server",
			"gopls",
			"html",
			"htmx",
			"lua_ls",
			"pyright",
			"rust_analyzer",
			"tailwindcss",
			"taplo",
			"templ",
			"tsserver",
			"yamlls",
		}

		for _, lsp in ipairs(servers) do
			lspconfig[lsp].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end
	end,
}
