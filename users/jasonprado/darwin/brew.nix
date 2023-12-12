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
    # brews = [
    #   {
    #     name = "mistertea/et/et";
    #     start_service = true;
    #     restart_service = "changed";
    #     link = true;
    #   }
    # ];
  };
}
