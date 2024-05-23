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

    # manual.manpages.enable = false;
    home.stateVersion = "23.05";

    fonts.fontconfig.enable = true;
    home.packages = with pkgs;
      [
        any-nix-shell
        bazel-buildtools
        btop
        cargo
        devenv
        gh
        glances
        git-absorb
        google-cloud-sdk
        kubectl
        kubernetes-helm
        nodejs_20
        nodePackages.aws-cdk
        nodePackages.pnpm
        nodePackages.typescript
        renameutils
        nodejs_20
        postgresql
        ruff
        rustc
        yarn
        yq
        zulu8
      ] ++ (if isLinux then [
        _1password-gui
        _1password
        alacritty
        cura
        inetutils
        inkscape-with-extensions
        rofi
        slack
        vlc
      ] else [
        getopt
      ]);

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
      gh = {
        enable = true;
        settings = {
          git_protocol = "https";

          prompt = "enabled";

          aliases = {
            co = "pr checkout";
            pv = "pr view";
          };
        };
      };
      go = {
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
        enableZshIntegration = true;
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
  } else {
    
  })
