return {
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			current_line_blame = true,
		},
		init = function()
			vim.keymap.set("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>")
			vim.keymap.set("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>")
		end,
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
		init = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Neogit)
		end,
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
}
