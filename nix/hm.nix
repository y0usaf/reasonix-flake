{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.reasonix;
  reasonixPkg = import ./package.nix {inherit pkgs;};
in {
  options.programs.reasonix = {
    enable = lib.mkEnableOption "reasonix cache-first DeepSeek coding agent";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [reasonixPkg];
  };
}
