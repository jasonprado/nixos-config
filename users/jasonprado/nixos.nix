{ pkgs, lib, inputs, ... }:

{
  programs.zsh.enable = true;
  
  users.users.jasonprado = {
    isNormalUser = true;
    home = "/home/jasonprado";
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = lib.attrsets.attrValues (import ./ssh-keys.nix);
    packages = with pkgs; [
      _1password-gui
      _1password
      bc
      discord
      docker
      firefox
      google-chrome
      kate
      obsidian
      plexamp
      synergy
      xkeysnail

      (python311.withPackages(ps: with ps; [
        i3ipc
      ]))

      xdotool
      xorg.xdpyinfo
      (writeShellScriptBin "i3-toggle-scratchpad" (lib.readFile ./bin/i3-toggle-scratchpad))
    ];
    # hashedPassword = "tbd";
  };
  home-manager.users.jasonprado.home.stateVersion = "23.11";
}
