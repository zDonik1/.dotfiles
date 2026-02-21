vim.opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,terminal"

return {
	"folke/persistence.nvim",
	keys = {
		{
			"<leader>js",
			function()
				require("persistence").select()
			end,
			desc = "Select session",
		},
		{
			"<leader>jx",
			function()
				require("persistence").stop()
			end,
			desc = "Disable session save",
		},
	},
	config = true,
}
