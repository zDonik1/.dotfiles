local function make_mappings()
	local cmp = require("cmp")
	local cmp_select = { behavior = cmp.SelectBehavior.Select }
	return {
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
end

-- expands mappings for each given mode
local function expand_mappings(mappings, modes)
	local new_mappings = {}
	for key, map_func in pairs(mappings) do
		new_mappings[key] = require("cmp").mapping(map_func, modes)
	end
	return new_mappings
end

return {
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
}
