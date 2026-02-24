{
  lib,
  config,
  libhelix,
  ...
}: {
  # Module
  options.nouritsu.helix = {
    enable = lib.mkEnableOption "nouritsu's helix configuration";

    spellcheck = lib.mkEnableOption "spellcheck with harper";

    integrations = {
      lazygit = lib.mkEnableOption "lazygit integration (<Leader>-g)";
      yazi = lib.mkEnableOption "yazi integration (<Leader>-e)";
    };

    languages = lib.mkOption {
      type = lib.types.listOf (lib.types.enum libhelix.supported_languages);
      default = [];
      description = "Language support";
    };
  };

  # Meta
  options.helix' = {
    binds_g = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "TOML keybindings for g minor mode";
    };

    binds_space = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "TOML keybindings for space minor mode";
    };

    languages = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [];
      description = "Language configurations (harper-ls injected automatically when spellcheck is enabled)";
    };
  };

  config.languages.language =
    map (
      lang:
        if config.nouritsu.helix.spellcheck
        then
          lang
          // {
            language-servers = (lang.language-servers or []) ++ ["harper-ls"];
          }
        else lang
    )
    config.helix'.languages;

  config.extraSettings = let
    cfg = config.helix';
  in
    /*
    toml
    */
    ''
      [keys.normal.g]
      ${cfg.binds_g}

      [keys.select.g]
      ${cfg.binds_g}

      [keys.normal.space]
      ${cfg.binds_space}

      [keys.select.space]
      ${cfg.binds_space}
    '';
}
