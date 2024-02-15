#
#  These are the different profiles that can be used when building NixOS.
#
#  flake.nix 
#   └─ ./hosts  
#       ├─ default.nix *
#       ├─ configuration.nix
#       ├─ home.nix
#       └─ ./desktop OR ./laptop OR ./work
#            ├─ ./default.nix
#            └─ ./home.nix 
#

{ lib, inputs, nixpkgs, home-manager, nur, user, location, ... }:

let
  system = "x86_64-linux";                                  # System architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;                              # Allow proprietary software
  };

  lib = nixpkgs.lib;
in
{
  desktop = lib.nixosSystem {                               # Desktop profile
    inherit system;
    specialArgs = {
      inherit inputs user location system;
      host = {
        hostName = "desktop";
        # mainMonitor = "HDMI-A-3";
        # secondMonitor = "DP-1";
      };
    };                                                      # Pass flake variable
    modules = [                                             # Modules that are used.
      nur.nixosModules.nur
      ./desktop
      ./configuration.nix

      home-manager.nixosModules.home-manager {              # Home-Manager module that is used.
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user;
          host = {
            hostName = "desktop";     #For Xorg iGPU  | Videocard 
            mainMonitor = "HDMI-A-3"; #HDMIA3         | HDMI-A-1
            secondMonitor = "DP-1";   #DP1            | DisplayPort-1
          };
        };                                                  # Pass flake variable
        home-manager.users.${user} = {
          imports = [
            ./home.nix
            ./desktop/home.nix
          ];
        };
      }
    ];
  };

  laptop = lib.nixosSystem {                                # Laptop profile
    inherit system;
    specialArgs = {
      inherit inputs user location;
      host = {
        hostName = "laptop";
        # mainMonitor = "eDP-1";
      };
    };
    modules = [
      ./laptop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            inherit user;
            host = {
              hostName = "letsnot";
              # mainMonitor = "eDP-1";
            };
          };
          users.${user} = {
            imports = [(import ./home.nix)] ++ [(import ./laptop/home.nix)];
          };
        };
      }
    ];
  };
}
