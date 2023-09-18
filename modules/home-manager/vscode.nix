
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    userSettings = {
      "diffEditor.experimental.useVersion2" = true;
      "editor.accessibilitySupport" = "off";
      "editor.fontFamily" = "FantasqueSansM Nerd Font Mono, Menlo, Monaco";
      "editor.formatOnPaste" = true;
      "editor.inlineSuggest.enabled" = true;
      "editor.minimap.autohide" = false;
      "nixEnvSelector.suggestion" = false;
      "r.bracketedPaste" = false;
      "r.rterm.mac" = "/run/current-system/sw/bin/radian";
      "vim.easymotion" = true;
      "vim.enableNeovim" = true;
      "vim.sneak" = true;
      "vim.sneakReplacesF" = true;
      "vim.statusBarColorControl" = false;
      "vim.useSystemClipboard" = true;
      "vim.normalModeKeyBindingsNonRecursive" = [
        {
          "before" = [ "g" "D" ];
          "commands" = [ "editor.action.revealDefinitionAside" ];
        }
        {
          "before" = [ "<space>" ];
          "commands" = [ "vspacecode.space" ];
        }
        {
          "before" = [ "," ];
          "commands" = [
            "vspacecode.space"
            {
              "command" = "whichkey.triggerKey";
              "args" = "m";
            }
          ];
        }
      ];
      "vim.visualModeKeyBindingsNonRecursive" = [
        {
          "before" = [ "<space>" ];
          "commands" = [ "vspacecode.space" ];
        }
        {
          "before" = [ ";" ];
          "commands" = [
            "vspacecode.space"
            {
              "command" = "whichkey.triggerKey";
              "args" = "m";
            }
          ];
        }
        {
          "before" = [ ">" ];
          "commands" = [ "editor.action.indentLines" ];
        }
        {
          "before" = [ "<" ];
          "commands" = [ "editor.action.outdentLines" ];
        }
      ];
      "workbench.colorTheme" = "Gruvbox Material Dark";
      "workbench.startupEditor" = "none";
      "vsicons.dontShowNewVersionMessage" = true;
    };


    extensions = with pkgs.vscode-extensions; [
      arrterian.nix-env-selector
      bbenoist.nix
      codezombiech.gitignore
      editorconfig.editorconfig
      esbenp.prettier-vscode
      github.copilot
      github.copilot-chat
      mikestead.dotenv
      mkhl.direnv
      ms-azuretools.vscode-docker
      ms-python.python
      ms-python.vscode-pylance
      ms-vscode-remote.remote-containers
      wmaurer.change-case
      yzhang.markdown-all-in-one
    ] ++ (
      with marketplace_extensions.vscode-marketplace; [
        camelcasenavigation
        # vspacecode.vspacecode
        # vspacecode.whichkey
        # ms-vscode-remote.remote-containers
      ]
    );
  };
}