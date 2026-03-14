{
  description = "nouritsu's wrapped helix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix.url = "github:helix-editor/helix/master";
  };

  nixConfig = {
    extra-substituters = [
      "https://helix.cachix.org"
    ];
    extra-trusted-public-keys = [
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
    ];
  };

  outputs = inputs: let
    inherit (inputs) flake-parts import-tree;
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./options.nix
        (import-tree ./modules)
        (import-tree ./packages)
      ];
      systems = ["x86_64-linux" "aarch64-linux"];
    };
}
