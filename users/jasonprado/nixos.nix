{ pkgs, inputs, ... }:

{
  programs.zsh.enable = true;
  
  users.users.jasonprado = {
    isNormalUser = true;
    home = "/home/jasonprado";
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      discord
      docker
      firefox
      google-chrome
      kate
      obsidian
      plexamp
      synergy
      xkeysnail
    ];
#     hashedPassword = "tbd";
#     openssh.authorizedKeys.keys = [
#       "ssh-ed25519 tbh jasonprado"
#     ];
  };
}
