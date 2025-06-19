vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.linebreak = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.smartindent = true
vim.opt.showmode = false
vim.opt.wrap = false
vim.opt.sidescroll = 5
vim.opt.listchars:append({ precedes = "<", extends = ">" })
vim.opt.fillchars:append({ diff = "/" })

if os.getenv("XDG_DATA_HOME") then
	vim.opt.directory = os.getenv("XDG_DATA_HOME") .. "/nvim-data/swap"
end
