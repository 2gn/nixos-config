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
      lmms
      thunderbird
      gimp
      # _1password-gui
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
