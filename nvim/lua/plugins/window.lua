return {
	"anuvyklack/windows.nvim",
	dependencies = { "anuvyklack/middleclass" },
	opts = {
		autowidth = {
			winwidth = 26, -- 80 + 20 + 6 (signcolumn) gives 100 column width
		},
		ignore = {
			filetype = {
				"undotree",
				"no-neck-pain",
				"Avante",
				"AvanteInput",
				"AvanteSelectedFiles",
			},
		},
	},
}
