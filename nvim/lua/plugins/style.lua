return {
	{
		"catppuccin/nvim",
		name = "catppuccin.nvim",
		lazy = false,
		opts = {
			show_end_of_buffer = true,
			custom_highlights = function(colors)
				return {
					Green = { fg = colors.green },
					Red = { fg = colors.red },
					Blue = { fg = colors.blue },
					Yellow = { fg = colors.yellow },

					["@text.emphasis"] = { fg = colors.green },
					["@markup.italic"] = { fg = colors.green },
					["@markup.quote"] = { fg = colors.lavender },
					rainbow1 = { bold = true },
					rainbow2 = { bold = true },
					rainbow3 = { bold = true },
					rainbow4 = { bold = true },
					rainbow5 = { bold = true },
					rainbow6 = { bold = true },

					RenderMarkdownH1Bg = { bg = "#4d363c" },
					RenderMarkdownH2Bg = { bg = "#4d3e36" },
					RenderMarkdownH3Bg = { bg = "#4d4536" },
					RenderMarkdownH4Bg = { bg = "#374d36" },
					RenderMarkdownH5Bg = { bg = "#36454d" },
					RenderMarkdownH6Bg = { bg = "#36394d" },
					RenderMarkdownCode = { bg = colors.mantle },
					RenderMarkdownCodeInline = { bg = colors.mantle },
					RenderMarkdownBullet = { link = "@markup.list" },
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
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = true,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		opts = {
			scope = { enabled = false },
		},
		config = function(_, opts)
			require("ibl").setup(opts)
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	{
		"Bekaboo/deadcolumn.nvim",
		init = function()
			vim.o.colorcolumn = "101"
		end,
		opts = {
			blending = { threshold = 1 },
		},
	},
}
