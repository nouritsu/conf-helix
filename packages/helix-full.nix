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
        self.nixosModules.whelix-options

        # core
        self.nixosModules.whelix-settings-editor
        self.nixosModules.whelix-settings-statusline
        self.nixosModules.whelix-settings-theme
        self.nixosModules.whelix-spellcheck

        # keybinds
        self.nixosModules.whelix-keybinds-core
        self.nixosModules.whelix-keybinds-buffer
        self.nixosModules.whelix-keybinds-easymotion
        self.nixosModules.whelix-keybinds-files
        self.nixosModules.whelix-keybinds-git
        self.nixosModules.whelix-keybinds-incdec
        self.nixosModules.whelix-keybinds-lsp

        # integrations
        self.nixosModules.whelix-integrations-lazygit
        self.nixosModules.whelix-integrations-yazi

        # lsp
        self.nixosModules.whelix-lsp-c
        self.nixosModules.whelix-lsp-cook-cli
        self.nixosModules.whelix-lsp-nix
        self.nixosModules.whelix-lsp-python
        self.nixosModules.whelix-lsp-rust
        self.nixosModules.whelix-lsp-slint
        self.nixosModules.whelix-lsp-typst
      ];
    };
  };
}
