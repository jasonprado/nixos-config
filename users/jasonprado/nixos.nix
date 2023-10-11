{ pkgs, inputs, ... }:

{
  users.users.jasonprado = {
    isNormalUser = true;
    home = "/home/jasonprado";
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    packages = with pkgs; [
      discord
      firefox
      kate
    ];
#     hashedPassword = "tbd";
#     openssh.authorizedKeys.keys = [
#       "ssh-ed25519 tbh jasonprado"
#     ];
  };
}
