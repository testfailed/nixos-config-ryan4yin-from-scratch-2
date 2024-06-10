{ lib
, inputs
, ...
} @ args: let
  inherit (inputs) haumea;

  # Contains all the flake outputs of this system architecture.
  data = haumea.lib.load {
    src = ./src;
    inputs = args;
  };

  # nix filenames are redundant, so we remove them.
  dataWithoutPaths = builtins.attrValues data;

  # Merge all machine's data into a single attribute set.
  outputs = {
    darwinConfigurations = lib.attrsets.mergeAttrsList (map (it: it.darwinConfigurations) dataWithoutPaths);
    packages = lib.attrsets.mergeAttrsList (map (it: it.packages) dataWithoutPaths);
    # TODO: colmenaMeta = { ... };
    # TODO: colmena = { ... };
  };
in
  outputs
  // {
    inherit data; # for debug purposes
      
    # NixOS's unit tests.
    evalTests = haumea.lib.loadEvalTests {
      src = ./tests;
      inputs = args // { inherit outputs; };
    };
  }
