return {
	"catppuccin/nvim",
	name = "catppuccin.nvim",
	lazy = false,
	opts = {
		show_end_of_buffer = true,
		custom_highlights = function(colors)
			return {
				["@text.emphasis"] = { fg = colors.green },
				["@markup.italic"] = { fg = colors.green },
				["rainbow1"] = { bold = true },
				["rainbow2"] = { bold = true },
				["rainbow3"] = { bold = true },
				["rainbow4"] = { bold = true },
				["rainbow5"] = { bold = true },
				["rainbow6"] = { bold = true },
			}
		end,
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
}
