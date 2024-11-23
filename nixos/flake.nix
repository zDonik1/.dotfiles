{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprswitch = {
      url = "github:h3rmt/hyprswitch/release";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zjstatus = {
      url = "github:dj95/zjstatus";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "nixos-wsl/flake-utils";
      };
    };

    # distant = {
    #   url = "./flakes/distant";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     flake-utils.follows = "nixos-wsl/flake-utils";
    #   };
    # };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      nixos-wsl,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      defaultModules =
        { home }:
        [
          home-manager.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.zdonik = home;
          }

          {
            nixpkgs.overlays = with inputs; [
              # (final: prev: { hyprland = hyprland.packages.${prev.system}.default; })
              (final: prev: { hyprswitch = hyprswitch.packages.${prev.system}.default; })
              (final: prev: { grimblast = hyprland-contrib.packages.${prev.system}.grimblast; })
              (final: prev: { zjstatus = zjstatus.packages.${prev.system}.default; })

              (final: prev: {
                rofi-calc = prev.rofi-calc.override { rofi-unwrapped = prev.rofi-wayland-unwrapped; };
              })

              # (final: prev: { distant = distant.packages.${prev.system}.default; })
            ];
          }
        ];
    in
    {
      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = defaultModules { home = ./home-wsl.nix; } ++ [
          ./hosts/wsl/configuration.nix
          nixos-wsl.nixosModules.wsl
        ];
      };

      nixosConfigurations.work-wsl = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = defaultModules { home = ./home-wsl.nix; } ++ [
          ./hosts/work-wsl/configuration.nix
          nixos-wsl.nixosModules.wsl
        ];
      };

      nixosConfigurations.tp-p53 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = defaultModules { home = ./home-gui.nix; } ++ [ ./hosts/tp-p53/configuration.nix ];
        specialArgs = {
          inherit pkgs-stable;
        };
      };
    };
}
