return {
	"folke/persistence.nvim",
	init = function()
		vim.opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,terminal"
		vim.keymap.set("n", "<leader>jw", require("persistence").load)
		vim.keymap.set("n", "<leader>js", require("persistence").select)
		vim.keymap.set("n", "<leader>jx", require("persistence").stop)
	end,
	config = true,
}
