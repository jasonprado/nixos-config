{ pkgs, ... }:
{
  imports = [
    ./fzf.nix
    ./git.nix
    ./vscode.nix
    ./zsh.nix
  ];
  home.stateVersion = "23.11";
  fonts.fontconfig.enable = true;

  home.packages = with pkgs;
    [
      nodePackages.typescript
      nodejs_20
      yarn
    ];

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
    zoxide = {
      enable = true;
    };
  };
}
