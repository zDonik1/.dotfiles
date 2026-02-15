return {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",
	dependencies = "rafamadriz/friendly-snippets",

	opts = {
		keep_roots = true,
		link_roots = true,
		exit_roots = false,
		link_children = true,
	},

	keys = {
		{
			"<C-k>",
			function()
				local ls = require("luasnip")
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end,
			mode = { "i", "s" },
			desc = "Expand snippet or jump to next tabstop",
			silent = true,
		},
		{
			"<C-j>",
			function()
				local ls = require("luasnip")
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end,
			mode = { "i", "s" },
			desc = "Jump to prevous tabstop",
			silent = true,
		},
		{
			"<C-l>",
			function()
				local ls = require("luasnip")
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end,
			mode = "i",
			desc = "Select next choice in snippets",
			silent = true,
		},
		{
			"<C-u>",
			function()
				require("luasnip.extras.select_choice")()
			end,
			mode = "i",
			desc = "Open choice selection menu for snippet",
			silent = true,
		},
	},

	config = function(_, opts)
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_vscode").load_standalone({
			path = ".vscode/project.code-snippets",
			lazy = true,
		})
		require("luasnip.loaders.from_lua").lazy_load({
			lazy_paths = "luasnippets",
		})

		require("luasnip").setup(opts)
	end,
}
