{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  name = "undug";
  packages = [
    pkgs.go
    pkgs.gopls
  ];
}
