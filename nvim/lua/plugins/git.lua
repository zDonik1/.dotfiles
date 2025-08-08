return {
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			disable_hint = true,
			graph_style = "unicode",
			mappings = {
				status = {
					["<c-t>"] = false,
					["<c-s>"] = false,
					["<c-a>"] = "StageAll",
					["<c-d>"] = "TabOpen",
				},
			},
		},
	},

	{
		"sindrets/diffview.nvim",
		cmd = "DiffviewOpen",
	},

	{
		"avm99963/vim-jjdescription",
		ft = ".jjdescription",
	},

	{
		"algmyr/vcsigns.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "algmyr/vcmarkers.nvim", opts = {} },
			"algmyr/vclib.nvim",
		},
		opts = {
			target_commit = 1, -- Nice default for jj with new+squash flow.
		},
		config = function(_, opts)
			require("vcsigns").setup(opts)

			local function map(mode, lhs, rhs, desc, opt)
				local options = { noremap = true, silent = true, desc = desc }
				if opt then
					options = vim.tbl_extend("force", options, opt)
				end
				vim.keymap.set(mode, lhs, rhs, options)
			end

			map("n", "[r", function()
				require("vcsigns").actions.target_older_commit(0, vim.v.count1)
			end, "Move diff target back")
			map("n", "]r", function()
				require("vcsigns").actions.target_newer_commit(0, vim.v.count1)
			end, "Move diff target forward")
			map("n", "[h", function()
				require("vcsigns").actions.hunk_prev(0, vim.v.count1)
			end, "Go to previous hunk")
			map("n", "]h", function()
				require("vcsigns").actions.hunk_next(0, vim.v.count1)
			end, "Go to next hunk")
			map("n", "[H", function()
				require("vcsigns").actions.hunk_prev(0, 9999)
			end, "Go to first hunk")
			map("n", "]H", function()
				require("vcsigns").actions.hunk_next(0, 9999)
			end, "Go to last hunk")
			map("n", "<leader>gr", function()
				require("vcsigns").actions.hunk_undo(0)
			end, "Undo hunks in range")
			map("n", "<leader>gh", function()
				require("vcsigns").actions.toggle_hunk_diff(0)
			end, "Show hunk diffs inline in the current buffer")
		end,
	},
}
