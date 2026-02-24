{inputs, ...}: let
  inherit (inputs) nixpkgs wrappers helix import-tree;

  supported_languages = [
    "c"
    "cook-cli"
    "nix"
    "python"
    "rust"
    "slint"
    "typst"
  ];
in {
  perSystem = {system, ...}: let
    common = [
      ./lib.nix
      ./options.nix
      {
        _module.args.supported_languages = supported_languages;
        pkgs = import nixpkgs {inherit system;};
        package = helix.packages.${system}.helix;
      }
      (import-tree ./modules)
    ];

    mk_helix = config: wrappers.wrappers.helix.wrap (common ++ [config]);
  in {
    packages = let
      full = mk_helix {
        nouritsu.helix = {
          enable = true;
          spellcheck = true;
          integrations.lazygit = true;
          integrations.yazi = true;
          languages = supported_languages;
        };
      };

      min = mk_helix {
        nouritsu.helix.enable = true;
      };
    in {
      default = full;

      helix-full = full;
      helix-min = min;
    };
  };
}
