return {
	{
		"shortcuts/no-neck-pain.nvim",
		cmd = { "NoNeckPain" },
		init = function()
			vim.keymap.set("n", "<leader>jn", vim.cmd.NoNeckPain, { desc = "Center wide buffers" })
		end,
		opts = {
			buffers = {
				wo = {
					fillchars = "eob: ",
				},
			},
		},
	},
}
