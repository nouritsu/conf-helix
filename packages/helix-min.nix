{
  self,
  inputs,
  ...
}: let
  inherit (inputs) nixpkgs wrappers helix;
in {
  perSystem = {system, ...}: {
    packages.helix-min = wrappers.wrappers.helix.wrap [
      {
        pkgs = import nixpkgs {inherit system;};
        package = helix.packages.${system}.helix;
      }
      self.nixosModules.whelix-options

      # core
      self.nixosModules.whelix-settings-editor
      self.nixosModules.whelix-settings-statusline
      self.nixosModules.whelix-settings-theme

      # keybinds
      self.nixosModules.whelix-keybinds-core
      self.nixosModules.whelix-keybinds-buffer
      self.nixosModules.whelix-keybinds-easymotion
      self.nixosModules.whelix-keybinds-files
      self.nixosModules.whelix-keybinds-git
      self.nixosModules.whelix-keybinds-incdec
      self.nixosModules.whelix-keybinds-lsp
    ];
  };
}
