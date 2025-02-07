local M = {}

local utils = require("yannik.core.utils")
local opts = {
	enabled = true,
	show_file_path = true,
	icons = {
		file_icon_default = "",
		seperator = ">",
	},
	exclude_filetype = {
		"help",
		"startify",
		"dashboard",
		"DressingInput",
		"packer",
		"neogitstatus",
		"NvimTree",
		"Trouble",
		"alpha",
		"lir",
		"Outline",
		"spectre_panel",
		"toggleterm",
		"TelescopePrompt",
		"qf",
	},
}

local hl_winbar_file_icon = "WinbarFileIcon"

local winbar_file = function()
	local status_web_devicons_ok, web_devicons = pcall(require, "nvim-web-devicons")
	local filename = vim.fn.expand("%:t")
	local file_type = vim.fn.expand("%:e")
	local winbar_title = ""
	local winbar_file_icon = opts.icons.file_icon_default

	if not utils.isempty(filename) then
		local default = false

		if utils.isempty(file_type) then
			file_type = ""
			default = true
		end

		if status_web_devicons_ok then
			winbar_file_icon, hl_winbar_file_icon = web_devicons.get_icon(filename, file_type, { default = default })
			if winbar_file_icon ~= nil then
				winbar_file_icon = "%#" .. hl_winbar_file_icon .. "#" .. winbar_file_icon .. " %*"
			end
		end

		if winbar_file_icon == nil then
			winbar_file_icon = opts.icons.file_icon_default
		end
		winbar_title = " " .. winbar_file_icon .. filename
	end
	return winbar_title .. ' %{&modified?"":""}'
end

local excludes = function()
	if vim.tbl_contains(opts.exclude_filetype, vim.bo.filetype) then
		vim.opt_local.winbar = nil
		return true
	end

	return false
end

M.show_winbar = function()
	if excludes() or vim.api.nvim_win_get_config(0).relative ~= "" then
		return
	end

	local title = winbar_file()

	local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", title, { scope = "local" })
	if not status_ok then
		return
	end
end

return M
