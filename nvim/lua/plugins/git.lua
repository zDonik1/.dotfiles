return {
	-- doesn't work with nushell for now: https://github.com/rbong/vim-flog/issues/121
	-- {
	-- 	"rbong/vim-flog",
	-- 	lazy = true,
	-- 	cmd = { "Flog", "Flogsplit", "Floggit" },
	-- 	dependencies = { "tpope/vim-fugitive" },
	-- },

	-- same as vim-flog
	-- {
	-- 	"junegunn/gv.vim",
	-- 	dependencies = { "tpope/vim-fugitive" },
	-- 	cmd = { "GV" },
	-- },

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
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},
}
