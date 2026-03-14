{
  flake.nixosModules.keybinds = {...}: {
    settings.keys = rec {
      normal = {
        "+" = "increment";
        "-" = "decrement";
      };

      select = {
        inherit (normal) "+" "-";
      };
    };
  };
}
