{
  description = "testfailed's nixos-config for Android (nix-on-droid)";

  inputs = {
    # TODO: update nixpkgs and nix-on-droid to v24.05
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nix-on-droid.url = "github:t184256/nix-on-droid/release-23.11";
    nix-on-droid.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ...  }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      # imports = [ ... ];

      systems = [ "aarch64-linux" ];

      # perSystem = { config, self', inputs', pkgs, system, ...  }: {
      #   ...
      # };

      flake = {
				# nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
				# 	modules = [ ./nix-on-droid.nix ];
				# };

				# TODO: Config for NixOS Server
				# nixosConfigurations...

				# TODO: Config for NixOS VM
				# nixosConfigurations...

				# TODO: Config for Macbook Air M1 (using nix-darwin)
				# darwinConfigurations...

				# Config for Android (using nix-on-droid)
				nixOnDroidConfigurations.default =
					inputs.nix-on-droid.lib.nixOnDroidConfiguration {
						modules = [ ./nix-on-droid.nix ];
					};
			};
		};
}
