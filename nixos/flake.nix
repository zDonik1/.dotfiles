{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    starship-jj = {
      url = "gitlab:lanastara_foss/starship-jj";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-rosetta-builder = {
      url = "github:cpick/nix-rosetta-builder";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zjstatus = {
      url = "github:dj95/zjstatus";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "nixos-wsl/flake-utils";
      };
    };
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      nixos-wsl,
      home-manager,
      catppuccin,
      starship-jj,
      nix-rosetta-builder,
      nur,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      nixpkgs-latest = nixpkgs;

      overlays =
        with inputs;
        [
          nur.overlays.default
          starship-jj.overlays.default

          (final: prev: { grimblast = hyprland-contrib.packages.${prev.system}.grimblast; })
          (final: prev: { zjstatus = zjstatus.packages.${prev.system}.default; })

          (final: prev: {
            rofi-calc = prev.rofi-calc.override { rofi-unwrapped = prev.rofi-wayland-unwrapped; };
          })

          (final: prev: { ftdv = prev.callPackage ./pkgs/ftdv.nix { }; })
        ]
        ++ (import ./upgrades.nix nixpkgs-latest);

      makeHomeManagerModules =
        {
          home,
          isDarwin,
        }:
        [
          (if isDarwin then home-manager.darwinModules.default else home-manager.nixosModules.default)

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bak";

              extraSpecialArgs = {
                catppuccin = catppuccin.packages.aarch64-darwin;
              };

              users.zdonik = {
                imports = [
                  home
                  catppuccin.homeModules.catppuccin
                ];
              };
            };
          }
        ];

      makeModuleSet =
        {
          host,
          profile,
          extra ? [ ],
          overlays ? [ ],
          isDarwin ? false,
        }:
        let
          prof = import profile;
        in
        [
          host
          { nixpkgs.overlays = overlays; }
        ]
        ++ extra
        ++ (if prof ? system then [ prof.system ] else [ ])
        ++ (
          if prof ? home then
            (makeHomeManagerModules {
              home = prof.home;
              inherit isDarwin;
            })
          else
            [ ]
        );
    in
    {
      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = makeModuleSet {
          host = ./hosts/wsl/configuration.nix;
          profile = ./profiles/cli.nix;
          extra = [ nixos-wsl.nixosModules.wsl ];
          inherit overlays;
        };
      };

      nixosConfigurations.work-wsl = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = makeModuleSet {
          host = ./hosts/work-wsl/configuration.nix;
          profile = ./profiles/cli.nix;
          extra = [ nixos-wsl.nixosModules.wsl ];
          inherit overlays;
        };
      };

      nixosConfigurations.think-hyprland = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = makeModuleSet {
          host = ./hosts/think;
          profile = ./profiles/hyprland.nix;
          inherit overlays;
        };
      };

      nixosConfigurations.think-awesome = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = makeModuleSet {
          host = ./hosts/think;
          profile = ./profiles/awesome.nix;
          inherit overlays;
        };
      };

      nixosConfigurations.think-plasma = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = makeModuleSet {
          host = ./hosts/think;
          profile = ./profiles/plasma.nix;
          inherit overlays;
        };
      };

      darwinConfigurations.zdonik-mac = nix-darwin.lib.darwinSystem {
        modules = makeModuleSet {
          host = ./hosts/mac;
          profile = ./profiles/mac.nix;
          inherit overlays;
          isDarwin = true;
        };
        specialArgs = { inherit nix-rosetta-builder; };
      };
    };
}
