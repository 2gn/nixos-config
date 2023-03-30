#
#  Home-manager configuration for macbook
#
#  flake.nix
#   ├─ ./darwin
#   │   ├─ ./default.nix
#   │   └─ ./home.nix *
#   └─ ./modules
#       └─ ./programs
#           └─ ./alacritty.nix
#

{ pkgs, ... }:

{
  home = {                                        # Specific packages for macbook
    packages = with pkgs; [
      # Terminal
      rust-analyzer
      gh
      fd
      ripgrep
      tealdeer
    ];
    stateVersion = "22.05";
  };

  programs = {
    zsh = {                                       # Post installation script is run in configuration.nix to make it default shell
      enable = true;
      history.size = 5000;
    };
    wezterm = {
        enable = true;
        package = pkgs.hello;
        extraConfig = ''
            local wezterm = require 'wezterm'
            return {
                font = wezterm.font 'Hasklug Nerd Font Mono',
                enable_tab_bar = false,
                color_scheme = "dracula",
            }
        '';
    };
    helix = {
      enable = true;
      settings = {
        theme = "dracula";
      };
    };
    zellij.enable = true;
  };
}
