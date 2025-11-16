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
          undug = pkgs.buildGoModule {
            pname = "undug";
            version = "0.1.0";
            src = ./.;

            vendorHash = null;

            meta = with pkgs.lib; {
              description = "Undug - Unduck but faster";
              homepage = "https://github.com/warbacon/undug";
              license = licenses.mit;
            };
          };

          default = self.packages.${system}.undug;
        };

        devShells.default = import ./shell.nix { inherit pkgs; };

        apps.default = {
          type = "app";
          program = "${self.packages.${system}.undux}/bin/undug";
        };
      }
    );
}
