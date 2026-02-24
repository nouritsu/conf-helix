{
  lib,
  pkgs,
  config,
  ...
}: let
  harper-ls = lib.getExe pkgs.harper;
in {
  languages = lib.mkIf config.nouritsu.helix.spellcheck {
    language-server = {
      harper-ls = {
        command = harper-ls;
        args = ["--stdio"];
        config.harper-ls = {
          dialect = "British";
        };
      };
    };
  };
}
