{
  self,
  inputs,
  ...
}: let
  inherit (inputs) nixpkgs wrappers helix;
in {
  perSystem = {system, ...}: {
    packages = rec {
      default = helix-full;

      helix-full = wrappers.wrappers.helix.wrap [
        {
          pkgs = import nixpkgs {inherit system;};
          package = helix.packages.${system}.helix;
        }
        self.nixosModules.options
        self.nixosModules.settings
        self.nixosModules.keybinds
        self.nixosModules.spellcheck
        self.nixosModules.integration-lazygit
        self.nixosModules.integration-yazi
        self.nixosModules.lsp-c
        self.nixosModules.lsp-cook-cli
        self.nixosModules.lsp-nix
        self.nixosModules.lsp-python
        self.nixosModules.lsp-rust
        self.nixosModules.lsp-slint
        self.nixosModules.lsp-typst
      ];
    };
  };
}
