{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

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
      nur,
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

      makeHomeManagerModules = home: [
        home-manager.nixosModules.default

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "bak";
            users.zdonik = home;
          };
        }
      ];

      overlayModule = {
        nixpkgs.overlays = with inputs; [
          nur.overlays.default

          (final: prev: { grimblast = hyprland-contrib.packages.${prev.system}.grimblast; })
          (final: prev: { zjstatus = zjstatus.packages.${prev.system}.default; })

          (final: prev: {
            rofi-calc = prev.rofi-calc.override { rofi-unwrapped = prev.rofi-wayland-unwrapped; };
          })

          # (final: prev: { distant = distant.packages.${prev.system}.default; })
        ];
      };
    in
    {
      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = (makeHomeManagerModules ./home-wsl.nix) ++ [
          overlayModule
          ./hosts/wsl/configuration.nix
          nixos-wsl.nixosModules.wsl
        ];
      };

      nixosConfigurations.work-wsl = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = (makeHomeManagerModules ./home-wsl.nix) ++ [
          overlayModule
          ./hosts/work-wsl/configuration.nix
          nixos-wsl.nixosModules.wsl
        ];
      };

      nixosConfigurations.think = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = (makeHomeManagerModules ./home-hyprland.nix) ++ [
          overlayModule
          ./hosts/think/configuration.nix
          ./system/greetd
          ./system/connman
          ./system/expressvpn
        ];
        specialArgs = {
          inherit pkgs-stable;
        };
      };
    };
}
