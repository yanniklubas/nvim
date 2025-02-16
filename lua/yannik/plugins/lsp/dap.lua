return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = true,
		keys = {
			{
				"<leader>dt",
				function()
					local ft = vim.fn.expand("%:e")
					if ft == "py" then
						local status_ok, dap_py = pcall(require, "dap-python")
						if not status_ok then
							return
						end
						dap_py.test_method()
					elseif ft == "rs" then
						local status_ok, dap_lldb = pcall(require, "nvim-dap-lldb")
						if not status_ok then
							return
						end
						dap_lldb.debug_test()
					elseif ft == "go" then
						local status_ok, dap_go = pcall(require, "dap-go")
						if not status_ok then
							return
						end
						dap_go.debug_test()
					elseif ft == "java" then
						local status_ok, jdtls = pcall(require, "jdtls")
						if not status_ok then
							return
						end
						jdtls.test_nearest_method()
					end
				end,
				mode = { "n" },
				desc = "[D]ebugger [T]oggle",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				mode = { "n" },
				desc = "[D]ebugger [B]reakpoint",
			},
			{
				"<leader>dx",
				function()
					require("dap").close()
					require("dapui").close()
				end,
				mode = { "n" },
				desc = "[D]ebugger e[X]it",
			},
			{
				"<leader>dut",
				function()
					require("dapui").toggle()
				end,
				mode = { "n" },
				desc = "[D]ebugger [T]oggle [U]I",
			},

			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				mode = { "n" },
				desc = "[D]ebugger [C]ontinue",
			},
			{
				"<leader>dr",
				function()
					require("dapui").open({ reset = true })
				end,
				mode = { "n" },
				desc = "[D]ebugger [R]eset",
			},
			{
				"<leader>dsi",
				function()
					require("dap").step_into()
				end,
				mode = { "n" },
				desc = "[D]ebugger [S]tep [I]nto",
			},
			{
				"<leader>dso",
				function()
					require("dap").step_over()
				end,
				mode = { "n" },
				desc = "[D]ebugger [S]tep [O]ver",
			},
			{
				"<leader>dsr",
				function()
					require("dap").step_out()
				end,
				mode = { "n" },
				desc = "[D]ebugger [S]tep [R]eturn",
			},
		},
		init = function()
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "🔴", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)

			-- Configure JavaScript/TypeScript debugger
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						require("mason-registry").get_package("js-debug-adapter"):get_install_path()
							.. "/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}

			for _, language in ipairs({ "javascript", "typescript" }) do
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
						runtimeExecutable = function()
							if require("lspconfig").util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then
								return "deno"
							end
							return "node"
						end,
						runtimeArgs = function()
							if require("lspconfig").util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then
								return {
									"run",
									"--inspect-wait",
									"--allow-all",
								}
							end
							return {}
						end,
						attachSimplePort = function()
							if require("lspconfig").util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then
								return 9229
							end
							return nil
						end,
					},
				}
			end

			-- Configure Codelldb
			dap.adapters["codelldb"] = {
				type = "executable",
				command = require("mason-registry").get_package("codelldb"):get_install_path() .. "/codelldb",
				detached = vim.fn.has("win32") == 0,
			}
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap" },
		config = true,
	},
	{
		"leoluz/nvim-dap-go",
		dependencies = { "mfussenegger/nvim-dap" },
		config = true,
		keys = {
			{
				"<leader>dgt",
				function()
					require("dap-go").debug_test()
				end,
				mode = { "n" },
				desc = "[D]ebug [G]o [T]est",
			},
		},
		ft = { "go" },
	},
	{
		"mfussenegger/nvim-dap-python",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			local py_dap = require("dap-python")
			local mason_registry = require("mason-registry")

			py_dap.setup(mason_registry.get_package("debugpy"):get_install_path() .. "/venv/bin/python")
		end,
		ft = { "python" },
	},
	{
		"julianolf/nvim-dap-lldb",
		dependencies = { "mfussenegger/nvim-dap" },
		config = true,
		ft = { "rust" },
	},
}
