{ system, isPersonal }:
{ lib, pkgs, ... }:

let
  isLinux = system == "x86_64-linux";
in
  lib.recursiveUpdate
  (lib.recursiveUpdate
  {
    imports = [
      ./fzf.nix
      ./git.nix
      ./zsh.nix
      # VSCode managed by nix is full of headaches.
      # (
      #   import ./vscode.nix { inherit system; }
      # )
    ];

    home.stateVersion = "23.05";

    fonts.fontconfig.enable = true;
    home.packages = with pkgs;
      [
        btop
        devenv
        glances
        cargo
        gh
        nodePackages.pnpm
        nodePackages.typescript
        nodejs_20
        vlc
        renameutils
        rustc
        yarn
      ] ++ (if isLinux then [
        _1password-gui
        _1password
        alacritty
        cura
        inetutils
        inkscape-with-extensions
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
      jq = {
        enable = true;
      };
      lf = {
        enable = true;
      };
      tmux = {
        enable = true;
        extraConfig = ''
          set-option -g set-titles on
          set-option -g set-titles-string "#{window_name}"
        '';
      };
      zoxide = {
        enable = true;
      };
    };

    xdg.configFile = {
      "bat/config".text = ''
        --theme="gruvbox-dark"
      '';
    };
  }
  (if isPersonal then {
    launchd.agents.glances = {
      enable = true;
      config = {
        Label = "glances";

        ProgramArguments = [
          "${pkgs.glances}/bin/glances"
          "-w"
        ];

        StandardErrorPath = "/Users/jasonprado/.local/state/launchd/logs/glances.stderr";
      };
    };
  } else {}))

  (if isLinux then {
    xdg.configFile = {
      "i3/config".text = builtins.readFile ./i3;
      "i3status/config".text = builtins.readFile ./i3status;
    };

    home.pointerCursor = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
      size = 16;
    };
  } else {})
