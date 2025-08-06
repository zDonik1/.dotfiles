return {
	{
		"allaman/emoji.nvim",
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		opts = {
			enable_cmp_integration = true,
		},
	},

	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			-- just add emoji source, but merge it with the rest of the sources in another spec
			local sources = {
				{ name = "emoji" },
			}
			if opts.sources ~= nil then
				vim.list_extend(sources, opts.sources)
			end
			return vim.tbl_deep_extend("force", opts, { sources = sources })
		end,
	},
}
