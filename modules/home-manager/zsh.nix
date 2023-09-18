{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true; # default shell on catalina
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting = {
      enable = true;
    };
    shellAliases = {
      ll = "ls -l";
      update = "darwin-rebuild switch --flake ~/.nixpkgs";
      nixcfg = "code ~/.config/nixpkgs";
      xcc = "rm -rf ~/Library/Developer/Xcode/DerivedData/*";
      odd = "open ~/Library/Developer/Xcode/DerivedData/";
      fdd = "find ~/Library/Developer/Xcode/DerivedData/* -name";
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