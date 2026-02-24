{
  lib,
  libhelix,
  pkgs,
  ...
}: let
  tinymist = lib.getExe pkgs.tinymist;
  typstyle = lib.getExe pkgs.typstyle;
in {
  languages.language-server = lib.mkIf (libhelix.lang_is_supported "typst") {
    tinymist = {
      command = tinymist;
      config = {
        exportPdf = "onSave";
        formatterMode = "typstyle";
      };
    };
  };

  helix'.languages = lib.mkIf (libhelix.lang_is_supported "typst") [
    {
      name = "typst";
      language-servers = ["tinymist"];
      formatter = {
        command = typstyle;
      };
      auto-format = true;
    }
  ];
}
