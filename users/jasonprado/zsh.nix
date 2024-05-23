{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
    };
    envExtra = ''
      if [[ $(uname) == 'Darwin' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
      # if ~/src/experiments/ivanwang/scripts/chaws.sh exists, source it
      if [ -f ~/src/bin/chaws.sh ]; then
        source ~/src/bin/chaws.sh
      fi
      if [ -f ~/src/FlightSystems/docker_fun.sh ]; then
        export AWS_DEVBOX_ID=i-097054f55f4c1be1f
        export DEVBOX_HOSTNAME=jason_prado_dev_machine
        source ~/src/FlightSystems/docker_fun.sh
      fi
      AWS_CONFIG_FILE="$HOME/src/cloud/build_tools/aws_configs/cloud_config"
      if [ -f "$AWS_CONFIG_FILE" ]; then
        export AWS_CONFIG_FILE="$AWS_CONFIG_FILE"
      fi
      any-nix-shell zsh --info-right | source /dev/stdin
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
        "kubectl"
        "python"
        "ssh-agent"
        "vscode"
      ];
      theme = "dst";
    };
  };
}
