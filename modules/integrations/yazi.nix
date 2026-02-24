{
  lib,
  pkgs,
  config,
  ...
}: let
  yazi = lib.getExe pkgs.yazi;
in {
  helix'.binds_space =
    lib.mkIf
    config.nouritsu.helix.integrations.yazi
    /*
    toml
    */
    ''
      e = [
        ":sh rm -f /tmp/yazi-path",
        ":insert-output ${yazi} %{buffer_name} --chooser-file=/tmp/yazi-path",
        ":open %sh{cat /tmp/yazi-path}",
        ":redraw"
      ]
    '';
}
