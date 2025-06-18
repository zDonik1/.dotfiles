vim.api.nvim_create_autocmd("BufReadPre", {
	pattern = "*.md",
	callback = function()
		vim.opt_local.conceallevel = 2
	end,
})

return {
	-- creates links with <C-m> which is undocumented, clashing with harpoon
	{
		"ixru/nvim-markdown",
		ft = "markdown",
		init = function()
			vim.g.vim_markdown_no_default_key_mappings = true
			vim.api.nvim_create_autocmd("BufReadPre", {
				pattern = "*.md",
				callback = function()
					local maps = {
						{ mode = "n", left = "]]", right = "<Plug>Markdown_MoveToNextHeader" },
						{ mode = "n", left = "[[", right = "<Plug>Markdown_MoveToPreviousHeader" },
						{
							mode = "n",
							left = "][",
							right = "<Plug>Markdown_MoveToNextSiblingHeader",
						},
						{
							mode = "n",
							left = "[]",
							right = "<Plug>Markdown_MoveToPreviousSiblingHeader",
						},
						{ mode = "n", left = "]c", right = "<Plug>Markdown_MoveToCurHeader" },
						{ mode = "n", left = "]u", right = "<Plug>Markdown_MoveToParentHeader" },
						{ mode = "n", left = "<C-c>", right = "<Plug>Markdown_Checkbox" },
						{ mode = "n", left = "<tab>", right = "<Plug>Markdown_Fold" },
						{ mode = "n", left = "O", right = "<Plug>Markdown_NewLineAbove" },
						{ mode = "n", left = "o", right = "<Plug>Markdown_NewLineBelow" },

						{ mode = "i", left = "<tab>", right = "<Plug>Markdown_Jump" },
						{ mode = "i", left = "<cr>", right = "<Plug>Markdown_NewLineBelow" },
						{
							mode = { "i", "v" },
							left = "<C-k>",
							right = "<Plug>Markdown_CreateLink",
						},
					}

					for _, map in ipairs(maps) do
						vim.keymap.set(
							map.mode,
							map.left,
							map.right,
							{ buffer = true, remap = true }
						)
					end
				end,
			})
		end,
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"echasnovski/mini.icons",
			{ "catppuccin/nvim", name = "catppuccin.nvim" },
		},
		opts = {
			preset = "obsidian",
			heading = {
				position = "inline",
				left_pad = 2,
				border = true,
			},
			quote = { repeat_linebreak = true },
			win_options = {
				showbreak = { default = "", rendered = "  " },
				breakindent = { default = false, rendered = true },
				breakindentopt = { default = "", rendered = "" },
			},
			code = { left_pad = 2 },
			pipe_table = { preset = "round" },
			sign = { enabled = false },

			checkbox = {
				unchecked = { icon = "󰄱 " },
				checked = { icon = "󰄲 " },
				custom = {
					cancelled = {
						raw = "[-]",
						rendered = "󰍵 ",
						highlight = "DiagnosticSignError",
					},
				},
			},
		},
	},
}
