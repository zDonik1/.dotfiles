return {
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
			{ "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset hunk" },
			{ "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
			{ "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage buffer" },
			{ "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo stage hunk" },
		},
		opts = {
			current_line_blame = true,
		},
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},

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
}
