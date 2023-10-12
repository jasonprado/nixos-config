{ system }:
{ pkgs, ... }:

let
  isLinux = system == "x86_64-linux";
in
{
  imports = [
    ./fzf.nix
    ./git.nix
    ./zsh.nix
    (
      import ./vscode.nix { inherit system; }
    )
  ];
  home.stateVersion = "23.11";
  fonts.fontconfig.enable = true;

  home.packages = with pkgs;
    [
      nodePackages.typescript
      nodejs_20
      yarn
    ] ++ (if isLinux then [
      _1password-gui
      _1password
      alacritty
      rofi
      slack
    ] else []);

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
    bat = {
      enable = true;
      config = {
        theme = "gruvbox-dark";
      };
    };
    fzf = {
      enable = true;
    };
    gpg = {
      enable = true;
    };
    tmux = {
      enable = true;
    };
    zoxide = {
      enable = true;
    };
  };

  xdg.configFile = {
    "bat/config".text = ''
      --theme="gruvbox-dark"
    '';
  } // (if isLinux then {
    "i3/config".text = builtins.readFile ./i3;
  } else {});

  home.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 16;
  };
}
