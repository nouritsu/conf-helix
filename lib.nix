{
  config,
  supported_languages,
  ...
}: {
  _module.args.libhelix = {
    inherit supported_languages;
    lang_is_supported = lang: builtins.elem lang config.nouritsu.helix.languages;
  };
}
