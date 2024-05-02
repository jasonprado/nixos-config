{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true; # default shell on catalina
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting = {
      enable = true;
    };
    envExtra = ''
      if [[ $(uname) == 'Darwin' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';
    shellAliases = {
      ll = "ls -l";
      update = "darwin-rebuild switch --flake ~/.nixpkgs";
      nixcfg = "code ~/.config/nixpkgs";
      xcc = "rm -rf ~/Library/Developer/Xcode/DerivedData/*";
      odd = "open ~/Library/Developer/Xcode/DerivedData/";
      fdd = "find ~/Library/Developer/Xcode/DerivedData/* -name";
      mosh = "mosh --predict=never";
      meshtastic = "/Users/jasonprado/Library/Python/3.9/bin/meshtastic";

      # boxes
      prax = "et praxist";
      heg = "et hegemony";
    };
    sessionVariables = {
      EDITOR = "code -w";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "1password"
        "aws"
        "docker"
        "dotenv"
        "gh"
        "git"
        "git-lfs"
        "github"
        "python"
        "ssh-agent"
        "vscode"
      ];
      theme = "dst";
    };
  };
}
