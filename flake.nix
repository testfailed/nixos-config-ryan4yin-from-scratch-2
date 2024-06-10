{
  description = "testfailed's nixos-config";

  outputs = inputs: import ./outputs inputs;

  inputs = {
    # nixpkgs repos
    # TODO: update nixpkgs and nix-on-droid to v24.05
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    nixpkgs-23-11.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:lnl7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";
    nix-on-droid.url = "github:t184256/nix-on-droid/release-23.11";
    nix-on-droid.inputs.nixpkgs.follows = "nixpkgs-23-11";

    # nix-systems
    all-systems.url = "github:nix-systems/default";
    linux-systems.url = "github:nix-systems/default-linux";
    darwin-systems.url = "github:nix-systems/default-darwin";

    # nix-homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core.url = "github:homebrew/homebrew-core";
    homebrew-core.flake = false;
    homebrew-cask.url = "github:homebrew/homebrew-cask";
    homebrew-cask.flake = false;
    homebrew-bundle.url = "github:homebrew/homebrew-bundle";
    homebrew-bundle.flake = false;
    homebrew-services.url = "github:homebrew/homebrew-services";
    homebrew-services.flake = false;
    homebrew-mongodb.url = "github:mongodb/homebrew-brew";
    homebrew-mongodb.flake = false;

    # nix-secrets
    agenix.url = "github:ryantm/agenix";
    secrets.url = "git+ssh://git@github.com/testfailed/nix-secrets.git";
    secrets.flake = false;

    # Nix-related tools
    flake-parts.url = "github:hercules-ci/flake-parts";
    haumea.url = "github:nix-community/haumea/v0.2.2";
    haumea.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # nixvim
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };
}
