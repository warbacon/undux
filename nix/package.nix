{ pkgs, lib }:

pkgs.buildGoModule {
  pname = "undug";
  version = "0.1.0";
  src = ../.;
  vendorHash = null;

  meta = with lib; {
    description = "Undug - Unduck but faster";
    homepage = "https://github.com/warbacon/undug";
    license = licenses.mit;
    mainProgram = "undug";
  };
}
