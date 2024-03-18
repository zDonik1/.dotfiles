return {
	"catppuccin/nvim",
	name = "catppuccin.nvim",
	lazy = false,
	opts = {
		show_end_of_buffer = true,
		custom_highlights = function(colors)
			return {
				["@text.emphasis"] = { fg = colors.green },
			}
		end,
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")

		-- make md headings bold
		for i = 1, 6 do
			local current_rainbow = "rainbow" .. tostring(i)
			local hl = vim.api.nvim_get_hl(0, { name = current_rainbow })
			hl.bold = true
			vim.api.nvim_set_hl(0, current_rainbow, hl)
		end
	end,
}
