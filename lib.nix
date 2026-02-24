{config, ...}: {
  _module.args.libhelix = {
    supported_languages = [
      "c"
      "cook-cli"
      "nix"
      "python"
      "rust"
      "slint"
      "typst"
    ];

    lang_is_supported = lang: builtins.elem lang config.nouritsu.helix.languages;
  };
}
