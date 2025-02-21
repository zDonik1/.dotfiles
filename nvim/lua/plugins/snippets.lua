return {
	"echasnovski/mini.snippets",
	version = false,
	event = "InsertEnter",
	dependencies = "rafamadriz/friendly-snippets",

	opts = function()
		local gen_loader = require("mini.snippets").gen_loader
		return {
			snippets = {
				gen_loader.from_lang(),
				gen_loader.from_file(".vscode/project.code-snippets"),
			},
		}
	end,
}
