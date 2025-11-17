flake:
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.services.undug;
in
{
  options.services.undug = {
    enable = mkEnableOption "Undug service";

    package = mkOption {
      type = types.package;
      default = flake.packages.${pkgs.stdenv.system}.default;
      defaultText = literalExpression "flake.packages.\${pkgs.system}.default";
      description = "The undug package to use";
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.undug = {
      description = "Undug service";
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];

      serviceConfig = {
        ExecStart = "${cfg.package}/bin/undug";
        Restart = "on-failure";
        RestartSec = 5;
      };
    };
  };
}
