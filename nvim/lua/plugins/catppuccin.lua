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
		-- make background transparent
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
}
