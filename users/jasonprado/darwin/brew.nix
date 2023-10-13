{
  homebrew = {
    enable = true;
    onActivation = { autoUpdate = true; cleanup = "zap"; upgrade = true; };
    casks = [
      "1password"
      "discord"
      "element"
      "hammerspoon"
      "obsidian"
      "plexamp"
      "slack"
      "steam"
      "tailscale"
      "warp"
      "zoom"
    ];
  };
}
