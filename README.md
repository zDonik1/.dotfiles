# .dotfiles


## Installation

### NixOS

The config is mainly written for NixOS, even though it didn't start that way. I prefer always working in NixOS now, since I can even use it in Windows with WSL2.

After installing NixOS:

```sh
cd ~
git clone .config https://github.com/zDonik1/.dotfiles.git
cd .config
sudo nixos-rebuild switch --flake ./nixos#wsl
```

If you want clipboard to work in Neovim in WSL, install scoop and run:

```sh
scoop install win32yank
```

### Windows

The only reason you might want the config in Windows is that WSL is not supported for some reason. The config was mainly written to be crossplatform before adding NixOS, but now it's supported on best effort basis.

Ensure that you have Visual Studio since the Telescope fzf native Neovim plugin should compile fzf.

Install scoop first and then run:

```powershell
cd $env:USERPROFILE
git clone .config https://github.com/zDonik1/.dotfiles.git
cd .config
install_packages.bat
```

## Hyprland

Hyprland hasn't been fully setup yet and there are a few issues to resolve.

Bugs:
- [ ] Resizing a pseudo tiled window using keybinds creates weird artifacts
- [ ] Resizing a pseudo tiled window using edge of the window disables resizing using keybinds or the edge

Features:
- [ ] There are no keybinds for working with window groups
- [ ] No widgets for controlling system functions (Volume)
- [ ] Focused window should be on top even when tiled

### Cool features not added yet

- Rofi calendar mode
