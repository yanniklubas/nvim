-- week_day: 1-7 (Sunday: 1)
local function getWeekDayOfCurrentWeek(week_day)
	local now = os.time()
	local day_in_seconds = 86400
	local t = os.date("*t", now)
	local time = now + ((week_day - t.wday) * day_in_seconds)
	-- local alias = tostring(os.date("%a %b %d %Y", time))
	local id = tostring(os.date("%Y-%m-%d-%a-%b-%d", time))
	return id .. "#^1"
end

return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	cmd = {
		"ObsidianOpen",
		"ObsidianNew",
		"ObsidianQuickSwitch",
		"ObsidianTags",
		"ObsidianToday",
		"ObsidianYesterday",
		"ObsidianTomorrow",
		"ObsidianWeekly",
		"ObsidianSearch",
		"ObsidianWorkspace",
	},
	event = {
		"BufReadPre " .. vim.fn.expand("~") .. "work/notes/**.md",
		"BufReadPre " .. vim.fn.expand("~") .. "personal/notes/**.md",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/personal/notes/",
			},
			{
				name = "work",
				path = "~/work/notes/",
			},
		},
		daily_notes = {
			folder = "dailies",
			date_format = "%Y-%m-%d-%a-%b-%d",
			template = "daily_template.md",
		},
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
		mappings = {
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			["<leader>oc"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true, desc = "[O]bsidian toggle [C]heckbox" },
			},
		},
		follow_url_func = function(url)
			vim.fn.jobstart({ "xdg-open", url })
		end,
		templates = {
			subdir = "templates",
			date_format = "%Y-%m-%d-%a-%b-%d",
			time_format = "%H-%M",
			substitutions = {
				alias_date = function()
					return os.date("%a %b %d %Y", os.time())
				end,
				title_date = function()
					return os.date("%a %b %d", os.time())
				end,
				yesterday = function()
					local day_in_seconds = 86400
					return os.date("%a-%b-%d-%Y", os.time() - day_in_seconds)
				end,
				tomorrow = function()
					local day_in_seconds = 86400
					return os.date("%a-%b-%d-%Y", os.time() + day_in_seconds)
				end,
				week = function()
					return os.date("%Y, Week %W", os.time())
				end,
				sunday = function()
					return getWeekDayOfCurrentWeek(0)
				end,
				monday = function()
					return getWeekDayOfCurrentWeek(2)
				end,
				tuesday = function()
					return getWeekDayOfCurrentWeek(3)
				end,
				wednesday = function()
					return getWeekDayOfCurrentWeek(4)
				end,
				thursday = function()
					return getWeekDayOfCurrentWeek(5)
				end,
				friday = function()
					return getWeekDayOfCurrentWeek(6)
				end,
				saturday = function()
					return getWeekDayOfCurrentWeek(7)
				end,
			},
		},
		picker = {
			-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
			name = "telescope.nvim",
			-- Optional, configure key mappings for the picker. These are the defaults.
			-- Not all pickers support all mappings.
			mappings = {
				-- Create a new note from your query.
				new = "<C-x>",
				-- Insert a link to the selected note.
				insert_link = "<C-l>",
			},
		},
	},
	init = function()
		vim.api.nvim_create_user_command("ObsidianWeekly", function()
			local client = require("obsidian").get_client()
			local templates = require("obsidian.templates")
			local Path = require("obsidian.path")
			local Note = require("obsidian.note")
			local path = Path.new(client.dir)
			local id = tostring(os.date("%Y, Week %W", os.time()))
			path = path / "weeklies" / (id .. ".md")
			local note = Note.new(id, {}, { "weekly-notes" }, path)
			if not note:exists() then
				templates.clone_template("weekly_template.md", path, client, note:display_name())
				note = Note.from_file(path)
			end
			client:open_note(note)
		end, {})
	end,
}
