return {
	"allaman/emoji.nvim",
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",

		{
			"hrsh7th/nvim-cmp",
			opts = {
				sources = {
					{ name = "emoji" },
				},
			},
		},
	},
	opts = {
		enable_cmp_integration = true,
	},
}
