return {
	"echasnovski/mini.snippets",
	version = false,
	event = "InsertEnter",
	dependencies = "rafamadriz/friendly-snippets",

	opts = function()
		local snippets = require("mini.snippets")
		return { snippets = { snippets.gen_loader.from_lang() } }
	end,
}
