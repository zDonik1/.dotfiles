return {
	"epwalsh/obsidian.nvim",
	event = {
		"BufReadPre " .. vim.fn.expand("~") .. "/SecondBrain/**.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/SecondBrain/**.md",
	},
	cmd = {
		"ObsidianQuickSwitch",
		"ObsidianDailies",
		"ObsidianToday",
		"ObsidianNew",
		"ObsidianTag",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	init = function()
		vim.keymap.set(
			"n",
			"<leader>oo",
			vim.cmd.ObsidianOpen,
			{ desc = "Obsidian: Open current note in Obsidian" }
		)
		vim.keymap.set(
			"n",
			"<leader>on",
			vim.cmd.ObsidianNew,
			{ desc = "Obsidian: Create new note" }
		)
		vim.keymap.set(
			"n",
			"<leader>oq",
			vim.cmd.ObsidianQuickSwitch,
			{ desc = "Obsidian: Open quick switch dialog" }
		)
		vim.keymap.set(
			"n",
			"<leader>od",
			vim.cmd.ObsidianDailies,
			{ desc = "Obsidian: Open dailies dialog" }
		)
		vim.keymap.set(
			"n",
			"<leader>oy",
			vim.cmd.ObsidianToday,
			{ desc = "Obsidian: Open today's note" }
		)
		vim.keymap.set(
			"n",
			"[o",
			vim.cmd.ObsidianPrevDay,
			{ desc = "Obsidian: Open previous day relative to current note" }
		)
		vim.keymap.set(
			"n",
			"]o",
			vim.cmd.ObsidianNextDay,
			{ desc = "Obsidian: Open next day relative to current note" }
		)
		vim.keymap.set(
			"n",
			"<leader>om",
			vim.cmd.ObsidianTemplate,
			{ desc = "Obsidian: Insert templates with dialog" }
		)
		vim.keymap.set(
			"n",
			"<leader>ot",
			vim.cmd.ObsidianTags,
			{ desc = "Obsidian: Open dialog for tags" }
		)
	end,
	config = function()
		local mocha = require("catppuccin.palettes").get_palette("mocha")

		require("obsidian").setup({
			sort_by = "accessed",
			disable_frontmatter = true,
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
				nvim_cmp = true,
				min_chars = 1,
			},
			new_notes_location = "current_dir",
			note_id_func = function(title)
				return title
			end,
			wiki_link_func = "use_path_only",
			mappings = {
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				["<leader>oh"] = {
					action = function()
						return require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true },
				},
			},
			callbacks = {
				---@param client obsidian.Client
				---@param workspace obsidian.Workspace
				post_set_workspace = function(client, workspace)
					client.log.info("Changing directory to %s", workspace.path)
					vim.cmd.cd(tostring(workspace.path))
				end,
			},
			ui = {
				checkboxes = {},
				bullets = {},
				external_link_icon = {},
				reference_text = {},
				highlight_text = {},
				tags = { hl_group = "ObsidianTag" },
				block_ids = {},
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
		})

		-- custom Ex commands
		local offset_daily = function(offset)
			local filename = vim.fn.expand("%:t:r")
			local year, month, day = filename:match("(%d+)-(%d+)-(%d+)")
			local date = os.time({ year = year, month = month, day = day })
			local client = require("obsidian").get_client()
			local note = client:_daily(date + (offset * 3600 * 24))
			client:open_note(note)
		end

		vim.api.nvim_create_user_command("ObsidianPrevDay", function(_)
			offset_daily(-1)
		end, {
			bang = false,
			bar = false,
			register = false,
			desc = "Create and switch to the previous daily note based on current buffer",
		})

		vim.api.nvim_create_user_command("ObsidianNextDay", function(_)
			offset_daily(1)
		end, {
			bang = false,
			bar = false,
			register = false,
			desc = "Create and switch to the next daily note based on current buffer",
		})
	end,
}
