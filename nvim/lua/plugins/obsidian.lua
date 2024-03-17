return {
	"epwalsh/obsidian.nvim",
	-- dir = "D:/nvim_projects/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	cmd = { "ObsidianQuickSwitch", "ObsidianDailies", "ObsidianToday" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local mocha = require("catppuccin.palettes").get_palette("mocha")

		require("obsidian").setup({
			sort_by = "accessed",
			disable_frontmatter = true,
			workspaces = {
				{
					name = "personal",
					path = "~/iCloudDrive/iCloud~md~obsidian/SecondBrain",
				},
			},
			daily_notes = {
				folder = "periodic_notes",
				template = "daily_template.md",
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
				hl_groups = {
					ObsidianTodo = { bold = true, fg = mocha.peach },
					ObsidianDone = { bold = true, fg = mocha.sapphire },
					ObsidianRightArrow = { bold = true, fg = mocha.peach },
					ObsidianTilde = { bold = true, fg = mocha.red },
					ObsidianBullet = { bold = true, fg = mocha.sky },
					ObsidianRefText = { underline = true, fg = mocha.mauve },
					ObsidianExtLinkIcon = { fg = mocha.mauve },
					ObsidianTag = { italic = true, fg = mocha.teal },
					ObsidianHighlightText = { bg = mocha.flamingo },
				},
			},
		})
	end,
}
