return {
	{
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
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = function()
			require("lualine").setup({})
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
		config = function()
			local add_hidden_flags = function(command)
				table.insert(command, "--hidden")
				table.insert(command, "--glob")
				table.insert(command, "!**/.git/*")
			end
			local vimgrep_arguments = { unpack(require("telescope.config").values.vimgrep_arguments) }

			require("telescope").setup({
				defaults = {
					vimgrep_arguments = add_hidden_flags(vimgrep_arguments),
				},
				pickers = {
					find_files = {
						find_command = add_hidden_flags({ "rg", "--files" }),
					},
				},
			})
			require("telescope").load_extension("fzf")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>kf", builtin.find_files, {})
			vim.keymap.set("n", "<leader>ko", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>kg", builtin.git_files, {})
			vim.keymap.set("n", "<leader>kw", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>kb", builtin.buffers, {})
		end,
	},

	{
		"ThePrimeagen/harpoon",
		keys = { "<leader>h", "<C-r>", "<C-m>", "<C-f>", "<C-p>" },
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()

			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():append()
			end)
			vim.keymap.set("n", "<leader>hh", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			vim.keymap.set("n", "<C-r>", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<C-m>", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<C-f>", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<C-p>", function()
				harpoon:list():select(4)
			end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<leader>hp", function()
				harpoon:list():prev()
			end)
			vim.keymap.set("n", "<leader>hn", function()
				harpoon:list():next()
			end)
		end,
	},

	{
		"max397574/better-escape.nvim",
		opts = {
			mapping = { "jk" },
			timeout = vim.o.timeoutlen,
			keys = "<esc>",
		},
	},

	{
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
	},

	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
	},

	{
		"rbong/vim-flog",
		lazy = true,
		cmd = { "Flog", "Flogsplit", "Floggit" },
		dependencies = { "tpope/vim-fugitive" },
	},

	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"petertriho/cmp-git",

			"L3MON4D3/LuaSnip",
			"VonHeikemen/lsp-zero.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			local expand_mappings = function(mappings, modes)
				local new_mappings = {}
				for key, map_func in pairs(mappings) do
					new_mappings[key] = cmp.mapping(map_func, modes)
				end
				return new_mappings
			end
			local mappings = {
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<Up>"] = cmp.mapping.select_prev_item(cmp_select),
				["<Down>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-Space>"] = cmp.mapping.complete(),
				["<Tab>"] = function(fallback)
					if cmp.visible() then
						cmp.confirm({ select = true })
					else
						fallback()
					end
				end,
				["<CR>"] = function(fallback)
					if cmp.visible() and cmp.get_active_entry() then
						cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
					else
						fallback()
					end
				end,
			}

			cmp.setup({
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip", keyword_length = 2 },
					{ name = "buffer", keyword_length = 3 },
				},
				formatting = require("lsp-zero").cmp_format(),
				mapping = expand_mappings(mappings, { "i", "s" }),
			})

			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "git" },
				}, {
					{ name = "buffer" },
				}),
			})

			cmp.setup.cmdline({ "/", "?" }, {
				sources = {
					{ name = "buffer" },
				},
				mapping = expand_mappings(mappings, { "c" }),
			})

			cmp.setup.cmdline(":", {
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				mapping = expand_mappings(mappings, { "c" }),
			})
		end,
	},

	{
		"mhartington/formatter.nvim",
		cmd = "FormatWrite",
		config = function()
			require("formatter").setup({
				filetype = {
					lua = { require("formatter.filetypes.lua").stylua },
					cpp = { require("formatter.filetypes.cpp").clangformat },
					rust = { require("formatter.filetypes.rust").rustfmt },
					cs = { require("formatter.filetypes.cs").csharpier },
					python = { require("formatter.filetypes.python").autopep8 },
				},
			})
		end,
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
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			current_line_blame = true,
		},
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
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
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
}
