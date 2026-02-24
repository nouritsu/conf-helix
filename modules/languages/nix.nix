{
  lib,
  libhelix,
  pkgs,
  ...
}: let
  nixd = lib.getExe pkgs.nixd;
  nil = lib.getExe pkgs.nil;
  alejandra = lib.getExe pkgs.alejandra;
in {
  languages.language-server = lib.mkIf (libhelix.lang_is_supported "nix") {
    nixd.command = nixd;
    nil.command = nil;
  };

  helix'.languages = lib.mkIf (libhelix.lang_is_supported "nix") [
    {
      name = "nix";
      scope = "source.nix";
      injection-regex = "nix";
      file-types = ["nix"];
      language-servers = ["nixd" "nil"];

      formatter.command = alejandra;
      auto-format = true;

      comment-token = "#";
      block-comment-tokens = {
        start = "/*";
        end = "*/";
      };

      indent = {
        tab-width = 2;
        unit = "  ";
      };
    }
  ];
}
