return {
	"numToStr/Comment.nvim",
	keys = "<leader>c",
	config = function()
		require("Comment").setup({
			toggler = {
				line = "<leader>cc",
				block = "<leader>bc",
			},
			opleader = {
				line = "<leader>c",
				block = "<leader>b",
			},
			extra = {
				above = "<leader>cO",
				below = "<leader>co",
				eol = "<leader>cA", -- add comment at the end of line
			},
		})
	end,
}
