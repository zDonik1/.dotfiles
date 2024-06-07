@echo off

scoop install^
 git^
 fd^
 fzf^
 zoxide

REM nushell
scoop install^
 nu^
 starship

REM neovim
scoop install^
 neovim^
 ripgrep^
 cmake^
 lua-language-server^
 stylua

REM git
scoop install^
 git^
 gitui^
 gh^
 gh-dash
gh extension install dlvhdr/gh-dash
