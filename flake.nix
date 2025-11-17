{
  description = "Undug 🦆";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          undug = pkgs.callPackage ./nix/package.nix { };
          default = self.packages.${system}.undug;
        };
        nixosModules.default = import ./nix/module.nix self;
        devShells.default = import ./shell.nix { inherit pkgs; };
        apps.default = {
          type = "app";
          program = "${self.packages.${system}.undux}/bin/undug";
        };
      }
    );
}
