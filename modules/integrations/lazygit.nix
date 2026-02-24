{
  lib,
  pkgs,
  config,
  ...
}: let
  lazygit = lib.getExe pkgs.lazygit;
in {
  helix'.binds_space =
    lib.mkIf
    config.nouritsu.helix.integrations.lazygit
    /*
    toml
    */
    ''
      g = [
        ":write-all",
        ":new",
        ":insert-output ${lazygit}",
        ":buffer-close!",
        ":redraw",
        ":reload-all"
      ]
    '';
}
