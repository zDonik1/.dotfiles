return {
	{
		"avm99963/vim-jjdescription",
		ft = ".jjdescription",
	},

	{
		"algmyr/vcsigns.nvim",
		event = "VeryLazy",
		keys = {
			{
				"[r",
				function()
					require("vcsigns").actions.target_older_commit(0, vim.v.count1)
				end,
				desc = "Move diff target back",
			},
			{
				"]r",
				function()
					require("vcsigns").actions.target_newer_commit(0, vim.v.count1)
				end,
				desc = "Move diff target forward",
			},
			{
				"[h",
				function()
					require("vcsigns").actions.hunk_prev(0, vim.v.count1)
				end,
				desc = "Go to previous hunk",
			},
			{
				"]h",
				function()
					require("vcsigns").actions.hunk_next(0, vim.v.count1)
				end,
				desc = "Go to next hunk",
			},
			{
				"[H",
				function()
					require("vcsigns").actions.hunk_prev(0, 9999)
				end,
				desc = "Go to first hunk",
			},
			{
				"]H",
				function()
					require("vcsigns").actions.hunk_next(0, 9999)
				end,
				desc = "Go to last hunk",
			},
			{
				"<leader>gr",
				function()
					require("vcsigns").actions.hunk_undo(0)
				end,
				desc = "Undo hunks in range",
			},
			{
				"<leader>gh",
				function()
					require("vcsigns").actions.toggle_hunk_diff(0)
				end,
				desc = "Show hunk diffs inline in the current buffer",
			},
		},
		opts = {
			show_delete_count = false,
		},
	},

	{
		"algmyr/vcmarkers.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<space>m]",
				function()
					require("vcmarkers").actions.next_marker(0, vim.v.count1)
				end,
				desc = "Go to next marker",
			},
			{
				"<space>m[",
				function()
					require("vcmarkers").actions.prev_marker(0, vim.v.count1)
				end,
				desc = "Go to previous marker",
			},
			{
				"<space>ms",
				function()
					require("vcmarkers").actions.select_section(0)
				end,
				desc = "Select the section under the cursor",
			},
			{
				"<space>mf",
				function()
					require("vcmarkers").fold.toggle(0)
				end,
				desc = "Fold outside markers",
			},
			{
				"<space>mc",
				function()
					require("vcmarkers").actions.cycle_marker(0)
				end,
				desc = "Cycle marker representations",
			},
		},
		opts = {},
	},

	{
		"rafikdraoui/jj-diffconflicts",
		cmd = { "JJDiffConflicts" },
	},

	{
		"julienvincent/hunk.nvim",
		cmd = { "DiffEditor" },
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},
}
