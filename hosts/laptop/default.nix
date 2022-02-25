#
#  Specific system configuration settings for desktop
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./laptop
#   │        ├─ default.nix *
#   │        └─ hardware-configuration.nix       
#   └─ ./modules
#       └─ ./desktop
#           └─ ./qemu
#               └─ default.nix
#

{ config, pkgs, ... }:

{
  imports =                                 # For now, if applying to other system, swap files
    [(import ./hardware-configuration.nix)] ++            # Current system hardware config @ /etc/nixos/hardware-configuration.nix
    [(import ../../modules/desktop/qemu)] ++              # Virtual Machines
    (import ../../modules/hardware);                      # Hardware devices


  boot = {                                  # Boot options
    kernelPackages = pkgs.linuxPackages_latest;

#   initrd.kernelModules = [ "amdgpu" ];    # Video drivers
#   kernelParams = [ "radeon.si_support=0" "amdgpu.si_support=1" ];     # Needed because GCN1 architecture    

    loader = {                              # EFI Boot
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {                              # Most of grub is set up for dual boot
        enable = true;
        version = 2;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;                 # Find all boot options
        configurationLimit = 2;
      };
      timeout = 1;                          # Grub auto select time
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    interfaces = {
      enp0s25.useDHCP = true;               # Change to correct network driver.
      wlo1.useDHCP = true;
    };
  };

  programs = {                              # No xbacklight, this is the alterantive
    dconf.enable = true;
    light.enable = true;
  };

  services = {
    tlp.enable = true;                      # TLP and auto-cpufreq for power management
    auto-cpufreq.enable = true;
    blueman.enable = true;
    dbus.packages = with pkgs; [
      polybar                               # systemctl status --user $*.service
      dunst
    ];
    xserver = {
      libinput = {                          # Trackpad support & gestures
        enable = true;
        touchpad.naturalScrolling = true;   # The correct way of scrolling
      };
#     videoDrivers = [                      # Video drivers
#       "amdgpu"
#     ];
      resolutions = [
        { x = 1600; y = 920; }
        { x = 1280; y = 720; }
        { x = 1920; y = 1080; }
      ];
    };
  };
}