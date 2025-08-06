local function make_mappings(cmp)
	local cmp_select = { behavior = cmp.SelectBehavior.Select }
	return {
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<Up>"] = cmp.mapping.select_prev_item(cmp_select),
		["<Down>"] = cmp.mapping.select_next_item(cmp_select),
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
	version = false,
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"petertriho/cmp-git",
		"abeldekat/cmp-mini-snippets",

		"VonHeikemen/lsp-zero.nvim",
		"onsails/lspkind.nvim",
	},
	opts = function(_, opts)
		local cmp = require("cmp")
		local sources = {
			{ name = "path" },
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "mini_snippets" },
			{ name = "buffer", keyword_length = 3 },
		}
		if opts.sources ~= nil then
			vim.list_extend(sources, opts.sources)
		end

		return vim.tbl_deep_extend("force", opts, {
			sources = sources,
			window = {
				documentation = cmp.config.window.bordered(),
				completion = vim.tbl_deep_extend("force", cmp.config.window.bordered(), {
					col_offset = -4,
					side_padding = 0,
				}),
			},
			formatting = {
				fields = {
					cmp.ItemField.Kind,
					cmp.ItemField.Abbr,
					cmp.ItemField.Menu,
				},
				format = function(entry, vim_item)
					local kind = require("lspkind").cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
					})(entry, vim_item)
					local strings = vim.split(kind.kind, "%s", { trimempty = true })
					kind.kind = " " .. (strings[1] or "") .. " "
					kind.menu = "    (" .. (strings[2] or "") .. ")"
					return kind
				end,
			},
			mapping = expand_mappings(make_mappings(cmp), { "i", "s" }),
			snippet = {
				expand = function(args)
					local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
					insert({ body = args.body }) -- Insert at cursor
					cmp.resubscribe({ "TextChangedI", "TextChangedP" })
					require("cmp.config").set_onetime({ sources = {} })
				end,
			},
		})
	end,
	config = function(_, opts)
		local cmp = require("cmp")
		local mappings = expand_mappings(make_mappings(cmp), { "c" })

		cmp.setup(opts)

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
			mapping = mappings,
		})

		cmp.setup.cmdline(":", {
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			mapping = mappings,
		})
	end,
}
