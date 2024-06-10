{
  # nixpkgs repos
  nixpkgs
, nixpkgs-unstable
, nixpkgs-darwin
, nixpkgs-23-11

, home-manager
, nix-darwin
, nix-on-droid

  # nix-systems
, all-systems
, linux-systems
, darwin-systems

  # nix-homebrew
, nix-homebrew
, homebrew-core
, homebrew-cask
, homebrew-bundle
, homebrew-services
, homebrew-mongodb

  # nix-secrets
, agenix
, secrets

  # Nix-related tools
, flake-parts
, treefmt-nix
, disko

  # nixvim
, nixvim

  # etc.
, ...
} @ inputs: let
  inherit (inputs.nixpkgs) lib;
  myLib = import ../lib { inherit lib; };
  myVars = import ../vars { inherit lib; };

  # Add my custom lib, vars, nixpkgs instance, and all the inputs to specialArgs,
  # so that I can use them in all my nixos/home-manager/darwin modules.
  genSpecialArgs = system:
    inputs
    // {
      inherit myLib myVars;

      # use unstable branch for some packages to get the latest updates
      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system; # refer the `system` parameter form outer scope recursively
        # To use chrome, we need to allow the installation of non-free software
        config.allowUnfree = true;
      };
      # pkgs-stable = import inputs.nixpkgs-stable {
      #   inherit system;
      #   # To use chrome, we need to allow the installation of non-free software
      #   config.allowUnfree = true;
      # };
    };

  # This is the args for all the haumea modules in this folder.
  args = { inherit inputs lib myLib myVars genSpecialArgs; };

  # modules for each supported system.
  nixosSystems = {
    x86_64-linux = import ./x86_64-linux (args // { system = "x86_64-linux"; });
    # aarch64-linux = import ./aarch64-linux (args // { system = "aarch64-linux"; });
  };
  darwinSystems = {
    # x86_64-darwin = import ./x86_64-darwin (args // { system = "x86_64-darwin"; });
    aarch64-darwin = import ./aarch64-darwin (args // { system = "aarch64-darwin"; });
  };

  allSystems = nixosSystems // darwinSystems;
  allSystemNames = lib.attrNames allSystems;
  allSystemValues = lib.attrValues allSystems;
  nixosSystemValues = lib.attrValues nixosSystems;
  darwinSystemValues = lib.attrValues darwinSystems;
in
flake-parts.lib.mkFlake { inherit inputs; } {
  systems = import all-systems;

  imports = [
    treefmt-nix.flakeModule
    nixos-flake.flakeModule
    colmena-flake.flakeModule

    # NOTE: CUSTOM:
    ./users
    ./home
    ./nixos
    ./nix-darwin
  ];

  perSystem = { config, self', inputs', pkgs, system, ... }: {
    # Flake inputs we want to update periodically
    # Run: `nix run .#update`.
    nixos-flake.primary-inputs = [
      "nixpkgs"
      "home-manager"
      "nix-darwin"
      "nixos-flake"
      "nix-index-database"
      "nixvim"
    ];

    # checks.${system} = {
    #   eval-tests = 
    # };

    # Formatter.
    treefmt.config = {
      projectRootFile = "flake.nix";
      programs.nixpkgs-fmt.enable = true;
    };
    formatter = config.treefmt.build.wrapper;

    # Packages.
    packages.default = self'.packages.activate;

    # Default shell.
    devShells.default = pkgs.mkShell {
      name = "default-shell";
      inputsFrom = [ config.treefmt.build.devShell ];
      packages = with pkgs; [
        bashInteractive
        gcc
        just
        colmena
        nixd
      ];
    };

  };

  flake = {
    # Add attribute sets into outputs, for debugging.
    # debugAttrs = { inherit nixosSystems darwinSystems allSystems allSystemNames; };
    debugAttrs = { inherit nixosSystems darwinSystems allSystems allSystemNames; };
    # debugAttrs = { inherit darwinSystems; };

    # user = "ssm";
    # linuxSystems = [ "x86_64-linux" "aarch64-linux" ];
    # darwinSystems = [ "aarch64-darwin" "x86_64-darwin" ];

    # TODO: Config for NixOS Server
    # nixosConfigurations...

    # TODO: Config for NixOS VM
    # nixosConfigurations...

    # TODO: Config for Macbook Air M1 (using nix-darwin)
    # darwinConfigurations = nixpkgs.lib.genAttrs darwinSystems (system: nix-darwin.lib.darwinSystem {
    #   inherit system;
    #   specialArgs = inputs;
    #   modules = [
    #     home-manager.darwinModules.home-manager
    #     nix-homebrew.darwinModules.nix-homebrew
    #     {
    #       nix-homebrew = {
    #         inherit user;
    #         # user = "ssm";
    #         enable = true;
    #
    #         enableRosetta = false;
    #         mutableTaps = false;
    #         taps = {
    #           "homebrew/homebrew-core" = homebrew-core;
    #           "homebrew/homebrew-cask" = homebrew-cask;
    #           "homebrew/homebrew-bundle" = homebrew-bundle;
    #           "homebrew/homebrew-services" = homebrew-services;
    #           "mongodb/homebrew-brew" = homebrew-mongodb;
    #         };
    #
    #         autoMigrate = true;
    #       };
    #     }
    #     # ./hosts/mac-m1/default.nix
    #   ];
    # });

    # darwinConfigurations."clv-mba-m1" = nix-darwin.lib.darwinSystem {
    #   modules = [ ./hosts/aarch64-darwin/clv-mba-m1/default.nix ];
    #   specialArgs = { inherit inputs; };
    # };

    # Darwin Hosts.
    darwinConfigurations =
      lib.attrsets.mergeAttrsList (map (it: it.darwinConfigurations or {}) darwinSystemValues);

    # Config for Android (using nix-on-droid)
    # nixOnDroidConfigurations = {
    #   droid = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
    #     modules = [ ./hosts/nix-on-droid/nix-on-droid.nix ];
    #     # config = ./hosts/nix-on-droid/nix-on-droid.nix;
    #     # system = "aarch64-linux";
    #   };
    # };

    # nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
    #   modules = [ ./nix-on-droid.nix ];
    # };

  };

}

