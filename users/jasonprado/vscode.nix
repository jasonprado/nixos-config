{ system }:
{ pkgs, ... }:
let
  marketplace_extensions =
    (import (builtins.fetchGit {
      url = "https://github.com/nix-community/nix-vscode-extensions";
      ref = "refs/heads/master";
      rev = "6dfad0b36b9cc407e8837b569b996c68840d01f2";
    })).extensions.${system};
in
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    userSettings = {
      "editor.formatOnPaste" = true;
      "editor.inlineSuggest.enabled" = true;
      "editor.minimap.autohide" = false;
      "nixEnvSelector.suggestion" = false;
      "workbench.editor.enablePreview" = false;

      "workbench.colorTheme" = "Dark High Contrast";
      "workbench.startupEditor" = "none";
      "vsicons.dontShowNewVersionMessage" = true;
      "editor.tabSize" = 2;
      "[typescript]" = {
        "editor.defaultFormatter" = "vscode.typescript-language-features";
        "editor.formatOnSave" = true;
      };
      "[typescriptreact]" = {
          "editor.defaultFormatter" = "vscode.typescript-language-features";
          "editor.formatOnSave" = true;
      };
      "[javascript]" = {
        "editor.defaultFormatter" = "vscode.typescript-language-features";
      };
      "explorer.confirmDelete" = false;
      "terminal.integrated.scrollback" = 5000;

      "terminal.integrated.enableMultiLinePasteWarning" = false;
      "editor.formatOnSave" = true;
      "terminal.integrated.allowChords" = false;
      "[html]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[jsonc]" = {
          "editor.defaultFormatter" = "rvest.vs-code-prettier-eslint";
      };
      "javascript.updateImportsOnFileMove.enabled" = "always";
      "typescript.updateImportsOnFileMove.enabled" = "always";

      "github.copilot.enable" = {
          "*" = true;
          "plaintext" = true;
          "markdown" = false;
          "scminput" = false;
      };
      "terminal.integrated.sendKeybindingsToShell" = true;
      "terminal.integrated.commandsToSkipShell" = [
        "workbench.action.quickOpen"
        "workbench.action.terminal.focusFind"
        "workbench.action.focusActiveEditorGroup"
      ];
    };

    keybindings = [
      {
          "key" = "ctrl+tab";
          "command" = "workbench.action.terminal.focus";
      }
      {
          "key" = "ctrl+tab";
          "command" = "workbench.action.focusActiveEditorGroup";
          "when" = "terminalFocus";
      }
      {
          "key" = "ctrl+alt+`";
          "command" = "workbench.action.terminal.focus";
      }
      {
          "key" = "ctrl+alt+`";
          "command" = "workbench.action.focusActiveEditorGroup";
          "when" = "terminalFocus";
      }
      {
          "key" = "ctrl+h";
          "command" = "workbench.action.navigateLeft";
      }
      {
          "key" = "ctrl+l";
          "command" = "workbench.action.navigateRight";
      }
      {
          "key" = "ctrl+x";
          "command" = "workbench.action.terminal.focusNext";
          "when" = "terminalFocus";
      }
      {
          "key" = "shift+ctrl+left";
          "command" = "maptz.camelcasenavigation.extendCamelLeftCommand";
          "when" = "editorTextFocus";
      }
      {
          "key" = "shift+ctrl+right";
          "command" = "maptz.camelcasenavigation.extendCamelRightCommand";
          "when" = "editorTextFocus";
      }
      {
          "key" = "ctrl+left";
          "command" = "maptz.camelcasenavigation.moveCamelLeftCommand";
          "when" = "editorTextFocus";
      }
      {
          "key" = "ctrl+right";
          "command" = "maptz.camelcasenavigation.moveCamelRightCommand";
          "when" = "editorTextFocus";
      }
      {
          "key" = "alt+right";
          "command" = "cursorWordStartRight";
          "when" = "editorTextFocus";
      }
      {
          "key" = "alt+shift+right";
          "command" = "cursorWordStartRightSelect";
          "when" = "editorTextFocus";
      }
      {
          "key" = "alt+left";
          "command" = "cursorWordStartLeft";
          "when" = "editorTextFocus";
      }
      {
          "key" = "alt+shift+left";
          "command" = "cursorWordStartLeftSelect";
          "when" = "editorTextFocus";
      }
    ];

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
      ms-vscode-remote.remote-ssh
      wmaurer.change-case
      yzhang.markdown-all-in-one
    ] ++ (
      with marketplace_extensions.vscode-marketplace; [
        dnicolson.binary-plist
        maptz.camelcasenavigation
        # vspacecode.vspacecode
        # vspacecode.whichkey
        # ms-vscode-remote.remote-containers
      ]
    );
  };
}
