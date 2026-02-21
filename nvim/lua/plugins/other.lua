return {
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-surround").setup()
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		dependencies = { "hrsh7th/nvim-cmp" },
		config = function()
			require("nvim-autopairs").setup()
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	{
		"tpope/vim-unimpaired",
		keys = { "[", "]" },
	},

	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Oil",
		config = function()
			require("oil").setup({
				float = {
					padding = 4,
					max_width = 100,
					max_height = 80,
				},
			})
		end,
	},

	{
		"folke/twilight.nvim",
		cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
		opts = {
			expand = {
				"function_declaration",
				"function_definition",
				"function",
				"method",
				"table_constructor",
				"table",
				"if_statement",
			},
		},
	},

	{
		"echasnovski/mini.operators",
		opts = {
			exchange = { prefix = "gy" },
			replace = { prefix = "gl" },
		},
	},

	{
		"jakemason/ouroboros.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = { "cpp", "hpp", "h", "c" },
		init = function()
			vim.api.nvim_create_autocmd({ "BufReadPre" }, {
				callback = function()
					vim.keymap.set(
						"n",
						"<leader>i",
						vim.cmd.Ouroboros,
						{ desc = "Open alternate (header/source) file" }
					)
				end,
			})
		end,
	},

	{
		"qvalentin/helm-ls.nvim",
		ft = "helm",
		opts = {},
	},
}
