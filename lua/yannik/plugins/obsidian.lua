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
	keys = {
		{
			"<leader>oo",
			"<CMD>ObsidianOpen<CR>",
			mode = "n",
			desc = "[O]pen the current in the [O]bsidian App",
		},
		{
			"<leader>on",
			"<CMD>ObsidianNew<CR>",
			mode = "n",
			desc = "Create a [N]ew [O]bsidian Note",
		},
		{
			"<leader>oq",
			"<CMD>ObsidianQuickSwitch<CR>",
			mode = "n",
			desc = "[Q]uickly switch to (or open) another note",
		},
		{
			"<leader>os",
			"<CMD>ObsidianSearch<CR>",
			mode = { "n", "v" },
			desc = "[S]earch (or create) another note",
		},
		{
			"<leader>oft",
			"<CMD>ObsidianTags<CR>",
			mode = "n",
			desc = "[F]ind notes by [T]ag",
		},
		{
			"<leader>oy",
			"<CMD>ObsidianToday -1<CR>",
			mode = "n",
			desc = "Open (or create) the daily note for [Y]esterday",
		},
		{
			"<leader>od",
			"<CMD>ObsidianToday<CR>",
			mode = "n",
			desc = "Open (or create) the [D]aily note for today",
		},
		{
			"<leader>ot",
			"<CMD>ObsidianToday 1<CR>",
			mode = "n",
			desc = "Open (or create) the daily note for [T]omorrow",
		},
		{
			"<leader>oc",
			function()
				require("obsidian").util.toggle_checkbox()
			end,
			mode = "n",
			desc = "Toggle the [C]heckbox in an [O]bsidian note",
		},
		{
			"<leader>ole",
			"<CMD>ObsidianLink<CR>",
			mode = "v",
			desc = "[L]ink selected text to an [E]xisting note",
		},
		{
			"<leader>oln",
			"<CMD>ObsidianLinkNew<CR>",
			mode = "v",
			desc = "[L]ink selected text to a [N]ew note",
		},
		{
			"<leader>ol",
			"<CMD>ObsidianFollowLink vsplit<CR>",
			mode = "n",
			desc = "Follow [L]ink under cursor in a vsplit",
		},
		{
			"<leader>oi",
			"<CMD>ObsidianTemplate<CR>",
			mode = "n",
			desc = "[I]nsert an [O]bsidian Template",
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		"some",
	},
	config = function()
		require("obsidian").setup({
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
		})
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
