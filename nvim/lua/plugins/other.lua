return {
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
	},

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
		"itchyny/calendar.vim",
		cmd = "Calendar",
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
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = {
				relative = "win",
			},
		},
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
			exchange = {
				prefix = "gy",
			},
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
						"<leader>a",
						vim.cmd.Ouroboros,
						{ desc = "Open alternate (header/source) file" }
					)
				end,
			})
		end,
	},

	{
		"stevearc/overseer.nvim",
		keys = {
			{ "<leader>mo", ":OverseerToggle<cr>" },
			{ "<leader>mr", ":OverseerRun<cr>" },
		},
		opts = {
			task_list = {
				direction = "right",
			},
		},
	},
}
