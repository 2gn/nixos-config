#
#  Home-manager configuration for laptop
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./laptop
#   │       └─ home.nix *
#   └─ ./modules
#       └─ ./desktop
#           └─ ./bspwm
#              └─ home.nix
#

{ pkgs, ... }:

{
  imports =
    [
      ../../modules/desktop/bspwm/home.nix # Window Manager
    ];

  home = {                                # Specific packages for laptop
    packages = with pkgs; [
      # Applications
      # libreoffice                         # Office packages
      arp-scan
      aircrack-ng
      anki
      dirb
      vlc
      gh
      sublime4
      lmms
      thunderbird
      gimp
      _ipassword-gui
      nmap
      nix-tree
      libreoffice
      wezterm

      # Display
      light                              # xorg.xbacklight not supported. Other option is just use xrandr.

      # Power Management
      auto-cpufreq                       # Power management
      tlp                                # Power management
    ];
  };

  programs = {
    wezterm.enable = true;
  };

  services = {                            # Applets
    blueman-applet.enable = true;         # Bluetooth
    network-manager-applet.enable = true; # Network
  };
}
