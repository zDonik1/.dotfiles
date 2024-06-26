@echo off

CALL scoop install^
 fd^
 fzf^
 zoxide^
 broot^
 just^
 eza

REM font
CALL scoop bucket add nerd-fonts
CALL scoop install nerd-fonts/JetBrainsMono-NF

REM nushell
CALL scoop install^
 nu^
 starship

REM neovim
CALL scoop install^
 neovim^
 ripgrep^
 cmake^
 lua-language-server^
 stylua

REM git
CALL scoop install^
 git^
 gitui^
 gh
gh extension install dlvhdr/gh-dash

REM python
CALL scoop install python
pip install^
 python-lsp-server^
 ruff^
 debugpy
