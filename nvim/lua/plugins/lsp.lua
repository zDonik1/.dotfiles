local lua_ls_opts = {
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if
			vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc")
		then
			return
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			diagnostics = { globals = { "vim" } },
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			workspace = {
				checkThirdParty = false,
				-- library = {
				-- 	vim.env.VIMRUNTIME,
				-- 	-- Depending on the usage, you might want to add additional paths here.
				-- 	-- "${3rd}/luv/library"
				-- 	-- "${3rd}/busted/library",
				-- },

				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
				library = vim.api.nvim_get_runtime_file("", true),
			},
		})
	end,
	settings = {
		Lua = {},
	},
}

local setup_lspconfigs = function()
	local lspconfig = require("lspconfig")
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = false

	local lsps = {
		"csharp_ls",
		"rust_analyzer",
		"wgsl_analyzer",
		"nushell",
		"gdscript",
		"nil_ls",
		"nixd",
		"pylsp",
		"ruff",
		"clangd",
		"cmake",
		"yamlls",
		"taplo",
		"gopls",
		"dartls",
		"helm_ls",
		"eslint",
		"ts_ls",
	}
	for _, lsp in ipairs(lsps) do
		lspconfig[lsp].setup({ capabilities = capabilities })
	end

	lua_ls_opts.capabilities = capabilities
	lspconfig.lua_ls.setup(lua_ls_opts)
end

return {
	"VonHeikemen/lsp-zero.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"j-hui/fidget.nvim",
	},
	branch = "v3.x",

	keys = function()
		local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
		local next_diagnostic, prev_diagnostic = ts_repeat_move.make_repeatable_move_pair(function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, function()
			vim.diagnostic.jump({ count = -1, float = true })
		end)

		return {
			{
				"]d",
				next_diagnostic,
				desc = "Go to next LSP diagnostic",
				mode = { "n", "x", "o" },
			},
			{
				"[d",
				prev_diagnostic,
				desc = "Go to previous LSP diagnostic",
				mode = { "n", "x", "o" },
			},
		}
	end,

	config = function()
		require("lsp-zero").extend_lspconfig()
		setup_lspconfigs()

		require("fidget").setup({
			notification = {
				window = {
					normal_hl = "Comment", -- Base highlight group in the notification window
					winblend = 0, -- Background color opacity in the notification window
					border = "none", -- Border around the notification window
					zindex = 45, -- Stacking priority of the notification window
					max_width = 0, -- Maximum width of the notification window
					max_height = 0, -- Maximum height of the notification window
					x_padding = 1, -- Padding from right edge of window boundary
					y_padding = 0, -- Padding from bottom edge of window boundary
					align = "bottom", -- How to align the notification window
					relative = "editor", -- What the notification window position is relative to
				},
			},
		})

		vim.diagnostic.config({
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
