local function new_zettel()
	local util = require("obsidian.util")
	local log = require("obsidian.log")
	local client = require("obsidian").get_client()

	local note
	local title = util.input("Enter title or path (optional): ", { completion = "file" })
	if not title then
		log.warn("Aborted")
		return
	elseif title == "" then
		title = nil
	end
	note = client:create_note({ title = title, no_write = true })
	client:open_note(note, { sync = true })
	client:write_note_to_buffer(note, { template = "note_template" })
end

local function offset_daily(offset)
	local filename = vim.fn.expand("%:t:r")
	local year, month, day = filename:match("(%d+)-(%d+)-(%d+)")
	require("obsidian.daily")
		.daily({
			date = os.time({ year = year, month = month, day = day }) + (offset * 3600 * 24),
		})
		:open()
end

return {
	"zDonik1/obsidian.nvim",
	branch = "disable-lsp",
	-- dir = "~/projects/obsidian.nvim",

	ft = "markdown",
	cmd = { "Obsidian" },
	keys = {
		{
			"<leader>oo",
			function()
				vim.cmd.Obsidian("open")
			end,
			desc = "Obsidian: Open current note in Obsidian",
		},
		{
			"<leader>on",
			function()
				vim.cmd.Obsidian("new_from_template")
			end,
			desc = "Obsidian: Create new note",
		},
		{
			"<leader>oz",
			new_zettel,
			desc = "Obsidian: Create new zettel",
		},
		{
			"<leader>oq",
			function()
				vim.cmd.Obsidian("quick_switch")
			end,
			desc = "Obsidian: Open quick switch dialog",
		},
		{
			"<leader>ob",
			function()
				vim.cmd.Obsidian("backlinks")
			end,
			desc = "Obsidian: Open backlinks",
		},
		{
			"<leader>od",
			function()
				vim.cmd.Obsidian("dailies")
			end,
			desc = "Obsidian: Open dailies dialog",
		},
		{
			"<leader>oy",
			function()
				vim.cmd.Obsidian("today")
			end,
			desc = "Obsidian: Open today's note",
		},
		{
			"[o",
			function()
				offset_daily(-1)
			end,
			desc = "Obsidian: Open previous day relative to current note",
		},
		{
			"]o",
			function()
				offset_daily(1)
			end,
			desc = "Obsidian: Open next day relative to current note",
		},
		{
			"<leader>om",
			function()
				vim.cmd.Obsidian("template")
			end,
			desc = "Obsidian: Insert templates with dialog",
		},
		{
			"<leader>ot",
			function()
				vim.cmd.Obsidian("tags")
			end,
			desc = "Obsidian: Open dialog for tags",
		},
	},

	---@module 'obsidian'
	---@type function|obsidian.config
	opts = function()
		local mocha = require("catppuccin.palettes").get_palette("mocha")

		return {
			legacy_commands = false,
			search = { sort_by = "accessed" },
			workspaces = {
				{ name = "personal", path = "~/SecondBrain" },
			},
			daily_notes = {
				folder = "periodic_notes",
				template = "daily_template.md",
				alias_format = "%Y-%m-%d",
			},
			templates = {
				subdir = "templates",
				time_format = "%X",
				substitutions = {
					["time:HH:mm:ss"] = function()
						return os.date("%X")
					end,
				},
			},
			completion = {
				nvim_cmp = false,
				min_chars = 1,
			},
			new_notes_location = "current_dir",
			note_id_func = function(title)
				return title
			end,
			link = { style = "wiki" },

			frontmatter = {
				func = function(note)
					local out = {
						id = note.id,
						date_created = os.date("%Y-%m-%dT%H:%M:%S"),
						type = "zettel",
					}
					if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
						for k, v in pairs(note.metadata) do
							out[k] = v
						end
					end
					return out
				end,
				sort = { "id", "date_created", "type" },
			},

			callbacks = {
				enter_note = function(note)
					local actions = require("obsidian.actions")
					vim.keymap.del("n", "<cr>", { buffer = true })
					vim.keymap.del("n", "]o", { buffer = true })
					vim.keymap.del("n", "[o", { buffer = true })

					vim.keymap.set(
						"n",
						"<CR>",
						actions.smart_action,
						{ expr = true, buffer = true, desc = "Obsidian Smart Action" }
					)

					vim.keymap.set("n", "]l", function()
						actions.nav_link("next")
					end, { buffer = true, desc = "Go to next link" })
					vim.keymap.set("n", "[l", function()
						actions.nav_link("prev")
					end, { buffer = true, desc = "Go to previous link" })
				end,
			},

			ui = {
				bullets = {},
				external_link_icon = {},
				reference_text = {},
				highlight_text = {},
				block_ids = { hl_group = "ObsidianBlockID" },
				hl_groups = {
					ObsidianTodo = { bold = true, fg = mocha.peach },
					ObsidianDone = { bold = true, fg = mocha.sapphire },
					ObsidianRightArrow = { bold = true, fg = mocha.peach },
					ObsidianTilde = { bold = true, fg = mocha.red },
					ObsidianBullet = { bold = true, fg = mocha.sky },
					ObsidianRefText = { underline = true, fg = mocha.lavender },
					ObsidianExtLinkIcon = { fg = mocha.lavender },
					ObsidianTag = { italic = true, fg = mocha.blue },
					ObsidianHighlightText = { bg = mocha.flamingo },
				},
			},
		}
	end,
}
