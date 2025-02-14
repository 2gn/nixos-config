#
#  These are the different profiles that can be used when building on MacOS
#
#  flake.nix
#   └─ ./darwin
#       ├─ ./default.nix *
#       ├─ configuration.nix
#       └─ home.nix
#

{ lib, inputs, nixpkgs, home-manager, darwin, user, ...}:

let
  system = "x86_64-darwin";                                 # System architecture
in
{
  macbook = darwin.lib.darwinSystem {                       # MacBook8,1 "Core M" 1.2 12" (2015) A1534 ECM2746 profile
    inherit system;
    specialArgs = { inherit user inputs; };
    modules = [                                             # Modules that are used
      ./configuration.nix

      home-manager.darwinModules.home-manager {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit user; };  # Pass flake variable
          users.${user} = import ./home.nix;
        };
      }
    ];
  };
}
