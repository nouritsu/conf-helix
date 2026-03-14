{self, inputs, ...}: let
  inherit (inputs) nixpkgs wrappers helix;
in {
  perSystem = {system, ...}: {
    packages.helix-min = wrappers.wrappers.helix.wrap [
      {
        pkgs = import nixpkgs {inherit system;};
        package = helix.packages.${system}.helix;
      }
      self.nixosModules.options
      self.nixosModules.settings
      self.nixosModules.keybinds
    ];
  };
}
