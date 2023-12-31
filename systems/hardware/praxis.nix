# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/87a2b1c3-3a26-4d23-bab2-370a119b6bb6";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-55a93f21-98c4-4ed4-8839-66be743ce0de".device = "/dev/disk/by-uuid/55a93f21-98c4-4ed4-8839-66be743ce0de";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/F18E-9622";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/04232749-a014-4f8f-9bb5-2e352b563447"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp86s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp87s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp88s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
