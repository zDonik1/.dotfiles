{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      expressvpn = pkgs.callPackage ./expressvpn.nix { };
    })
  ];

  services.expressvpn.enable = true;
  environment.systemPackages = [ pkgs.expressvpn ];
}
