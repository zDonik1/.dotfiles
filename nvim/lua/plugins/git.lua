return {
	-- doesn't work with nushell for now: https://github.com/rbong/vim-flog/issues/121
	{
		"rbong/vim-flog",
		lazy = true,
		cmd = { "Flog", "Flogsplit", "Floggit" },
		dependencies = { "tpope/vim-fugitive" },
		init = function()
			-- vim.keymap.set("n", "<leader>gs", vim.cmd.Floggit)
			vim.keymap.set("n", "<leader>gl", vim.cmd.Flog)
			vim.keymap.set("n", "<leader>gp", "<cmd>Floggit push<cr>")
			vim.keymap.set("n", "<leader>gP", "<cmd>Floggit pull --rebase<cr>")
			vim.keymap.set("n", "<leader>gi", function()
				vim.fn.feedkeys(":Floggit ")
			end)
		end,
	},

	{
		"tpope/vim-fugitive",
		cmd = { "G", "Git" },
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			current_line_blame = true,
		},
		init = function()
			vim.keymap.set("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>")
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
		config = true,
	},

	-- {
	-- 	"ThePrimeagen/git-worktree.nvim",
	-- },
}
