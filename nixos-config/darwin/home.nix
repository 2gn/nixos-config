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

let
  devenv = import (pkgs.fetchFromGitHub {
    owner = "cachix";
    repo = "devenv";
    rev = "52232ba41b7c531eacec4cf192d87241bef1a0d1";
    sha256 = "sha256-w1Y/S3TylKylTHCp+YkOJbiAE2LBBF1sKIKuLDW4fkU=";
  });
in
{
  imports = [
    ../modules/programs/wezterm.nix    
  ];
  home = {                                        # Specific packages for macbook
    packages = with pkgs; [
      # Terminal
      rust-analyzer
      gh
      fd
      sshpass
      devenv
      ripgrep
      tealdeer
      nodePackages.typescript-language-server
      typescript
    ];
    stateVersion = "22.05";
  };
  programs = {
    zsh = {                                       # Post installation script is run in configuration.nix to make it default shell
      enable = true;
      history.size = 5000;
      initExtra = ''
        if [[ -z "$ZELLIJ" ]]; then
          if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
            zellij attach -c
          else
            zellij
          fi

          if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
            exit
          fi
        fi
      '';
    };
    broot = {
      enable = true;
      settings = {
        verbs = [
          {invocation="edit";shortcut="e";execution="$EDITOR {file}";}
          {invocation="edit";key="enter";external="$EDITOR {file}";leave_broot=false;apply_to="file";}
        ];
        modal = true;
      };
      enableZshIntegration = true;
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
