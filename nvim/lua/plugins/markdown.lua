return {
	{
		"ixru/nvim-markdown",
		ft = "markdown",
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"echasnovski/mini.icons",
			{ "catppuccin/nvim", name = "catppuccin.nvim" },
		},
		opts = {
			preset = "obsidian",
			heading = {
				position = "inline",
				left_pad = 2,
				border = true,
			},
			quote = { repeat_linebreak = true },
			win_options = {
				showbreak = { default = "", rendered = "  " },
				breakindent = { default = false, rendered = true },
				breakindentopt = { default = "", rendered = "" },
			},
			code = { left_pad = 2 },
			pipe_table = { preset = "round" },
			sign = { enabled = false },
		},
	},
}
