#
# Terminal Emulator
#
# Hardcoded as terminal for rofi and doom emacs
#

{ pkgs, ... }:

{
  programs = {
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
  };
}
