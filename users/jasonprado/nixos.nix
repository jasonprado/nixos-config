{ pkgs, inputs, ... }:

{
  users.users.jasonprado = {
    isNormalUser = true;
    home = "/home/jasonprado";
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    packages = with pkgs; [
      discord
      docker
      firefox
      google-chrome
      kate
      obsidian
      plexamp
      xkeysnail
    ];
#     hashedPassword = "tbd";
#     openssh.authorizedKeys.keys = [
#       "ssh-ed25519 tbh jasonprado"
#     ];
  };
}
