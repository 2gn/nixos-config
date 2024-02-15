#
#  Specific system configuration settings for MacBook
#
#  flake.nix
#   └─ ./darwin
#       ├─ ./default.nix
#       └─ ./configuration.nix *
#

{ config, pkgs, user, ... }:

{
  imports = [
    ./modules/yabai.nix
    ./modules/skhd.nix
  ];
  
  nix = {
    package = pkgs.nixFlakes;
    gc = {                                # Garbage collection
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
    '';
  };
  
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  users.users."${user}" = {               # macOS user
    home = "/Users/${user}";
    shell = pkgs.zsh;                     # Default shell
  };

  networking = {
    computerName = "clamshell";             # Host name
    hostName = "clamshell";
  };

  fonts = {                               # Fonts
    fontDir.enable = true;
    fonts = with pkgs; [
      source-code-pro
      font-awesome
      (nerdfonts.override {
        fonts = [
          "Hasklig"
        ];
      })
    ];
  };

  environment = {
    shells = with pkgs; [ zsh ];          # Default shell
    variables = {                         # System variables
      EDITOR = "hx";
      TERM="xterm-color";
      ZELLIJ_AUTO_START="true";
      VISUAL = "hx";
    };
    systemPackages = with pkgs; [         # Installed Nix packages
      # Terminal
      ansible
      git
      ranger
      zellij
      nil
      helix
      arp-scan
      nix-review
      cachix
      ffmpeg

      # Doom Emacs
      fd
      ripgrep
    ];
  };
  
  documentation = {
    enable = true;
    doc.enable = true;
    man.enable = true;
  };

  programs = {                            # Shell needs to be enabled
    zsh.enable = true;
  };

  services = {
    nix-daemon.enable = true;             # Auto upgrade daemon
  };

  homebrew = {                            # Declare Homebrew using Nix-Darwin
    enable = true;
    onActivation = {
      autoUpdate = false;                 # Auto update packages
      upgrade = false;
      cleanup = "zap";                    # Uninstall not listed packages and casks
    };
    casks = [
      # "1password"
      # "1password-cli"
      "anki"
      "alt-tab"
      "audacity"
      "barrier"
      "balenaetcher"
      "ballast"
      "blackhole-2ch"
      "gimp-dev"
      "git-credential-manager-core"
      "inkscape"
      "karabiner-elements"
      # "lapce"
      "lulu"
      "netnewswire"
      "monitorcontrol"
      "michaelvillar-timer"
      "obsidian"
      "raspberry-pi-imager"
      "rectangle"
      "sublime-text"
      "scoot"
      "swiftcord"
      # "tribler"
      "vym"
      "vlc"
      "wireshark"
      "wezterm"
      "zoom"
    ] ++ [
      "ableton-live-lite"
      "bespoke"
      "vital"
      "spitfire-audio"
      "uhe-protoverb"
    ];
    brews = [
      "makeicns"
      "terminal-notifier"
      "wireguard-tools"
    ];
    taps = [
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/autoupdate"
      "homebrew/homebrew-cask-versions"
      "microsoft/git"
      "2gn/homebrew-audio-plugins"
      "nrlquaker/createzap"
    ];
    masApps = {
			xcode = 497799835;
			numbers = 409203825;
			brother-iprint-scan = 1193539993;
			pages = 409201541;
			shazam = 897118787;
			garageband = 682658836;
			raivo-otp = 1498497896;
			vimari = 1480933944;
			onedrive = 823766827;
    };
  };

  system = {
    defaults = {
      dock = {                            # Dock settings
        autohide = true;
        mouse-over-hilite-stack = true;
        minimize-to-application = true;
        orientation = "bottom";
        wvous-bl-corner = 1;
        showhidden = true;
        tilesize = 40;
      };
      NSGlobalDomain = {                  # Global macOS system settings
        "com.apple.trackpad.trackpadCornerClickBehavior" = 1;
        "com.apple.trackpad.enableSecondaryClick" = true;
        "com.apple.mouse.tapBehavior" = 1;
        AppleInterfaceStyleSwitchesAutomatically = true;
        ApplePressAndHoldEnabled = false;
        NSWindowShouldDragOnGesture = true;
        KeyRepeat = 1;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
      };
      finder = {                          # Finder settings
        QuitMenuItem = false;             # I believe this probably will need to be true if using spacebar
      };  
      trackpad = {                        # Trackpad settings
        Clicking = true;
        ActuationStrength = 0;
        SecondClickThreshold = 1;
        TrackpadRightClick = true;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
    activationScripts.postActivation.text = ''sudo chsh -s ${pkgs.zsh}/bin/zsh''; # Since it's not possible to declare default shell, run this command after build
    stateVersion = 4;
  };
}
