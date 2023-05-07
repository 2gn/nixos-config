{ pkgs, ... }:

{
  programs = {
    wezterm = {
      enable = true;
      package = pkgs.hello;
      extraConfig = ''
				local wezterm = require 'wezterm'
        function scheme_for_appearan(appearance)
          if appearance:find("Dark") then
            return "Maia (Gogh)"
          else
            return "Material"
          end
        end

        wezterm.on("window-config-reloaded", function(window, pane)
          local overrides = window:get_config_overrides() or {}
          local apparance = window:get_appearance()
          local scheme = scheme_for_appearance(appearance)
          if overrides.color_scheme ~= scheme then
            overrides.color_scheme = scheme
            window:set_config_overrides(overrides)
          end
        end)
        
				return {
					font = wezterm.font 'Hasklug Nerd Font Mono',
					enable_tab_bar = false,
				}
      '';
    };
  };
}
