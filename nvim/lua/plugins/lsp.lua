local set_lsp_maps = function(opts)
	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vks", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("v", "<leader>vca", function()
		vim.lsp.buf.range_code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end

local lua_ls_opts = {
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
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

return {
	"VonHeikemen/lsp-zero.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	branch = "v3.x",
	init = function()
		local lsp_zero = require("lsp-zero")
		lsp_zero.on_attach(function(_, bufnr)
			set_lsp_maps({ buffer = bufnr, remap = false })
		end)

		lsp_zero.extend_lspconfig()
		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				-- "tsserver",
				-- "rust_analyzer",
				-- "clangd",
				-- "denols",
				-- "gopls",
				-- "golangci_lint_ls",
				-- "pylsp",
				--                "csharp_ls",
			},
			handlers = {
				lsp_zero.default_setup,
				lua_ls = function()
					require("lspconfig").lua_ls.setup(lua_ls_opts)
				end,
			},
		})

		-- mason unsupported lsps
		require("lspconfig").nushell.setup({})
	end,
}
