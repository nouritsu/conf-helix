{
  lib,
  libhelix,
  pkgs,
  ...
}: let
  tinymist = lib.getExe pkgs.tinymist;
  typstyle = lib.getExe pkgs.typstyle;
in {
  languages = lib.mkIf (libhelix.lang_is_supported "typst") {
    language-server = {
      tinymist = {
        command = tinymist;
        config = {
          exportPdf = "onSave";
          formatterMode = "typstyle";
        };
      };
    };
    language = [
      {
        name = "typst";
        language-servers = ["tinymist"];
        formatter = {
          command = typstyle;
        };
        auto-format = true;
      }
    ];
  };
}
