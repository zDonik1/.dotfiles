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

      overlays = with inputs; [
        nur.overlays.default

        (final: prev: { grimblast = hyprland-contrib.packages.${prev.system}.grimblast; })
        (final: prev: { zjstatus = zjstatus.packages.${prev.system}.default; })

        (final: prev: {
          rofi-calc = prev.rofi-calc.override { rofi-unwrapped = prev.rofi-wayland-unwrapped; };
        })

        # (final: prev: { distant = distant.packages.${prev.system}.default; })
      ];

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

      makeModuleSet =
        {
          host,
          profile,
          extra ? [ ],
          overlays ? [ ],
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
        ++ (if prof ? home then (makeHomeManagerModules prof.home) else [ ]);
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
        specialArgs = { inherit pkgs-stable; };
      };

      nixosConfigurations.think-awesome = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = makeModuleSet {
          host = ./hosts/think;
          profile = ./profiles/awesome.nix;
          inherit overlays;
        };
        specialArgs = { inherit pkgs-stable; };
      };

      nixosConfigurations.think-plasma = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = makeModuleSet {
          host = ./hosts/think;
          profile = ./profiles/plasma.nix;
          inherit overlays;
        };
      };
    };
}
