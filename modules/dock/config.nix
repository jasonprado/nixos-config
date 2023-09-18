{ user, ... }: {
  enable = true;
  entries = [
    { path = "/System/Applications/Messages.app/"; }
    { path = "/Applications/Discord.app/"; }
    { path = "/Applications/Slack.app/"; }
    { path = "/System/Applications/Fantastical.app/"; }
    { path = "/Applications/Plexamp.app"; }
    { path = "/System/Applications/Photos.app/"; }
    { path = "/Users/${user}/Applications/Home Manager Apps/Visual Studio Code.app"; }
    { path = "/Applications/Obsidian.app/"; }
    { path = "/Applications/1Password.app/"; }
    {
      path = "";
      options = "--type small-spacer --section apps --after Plexamp";
    }
    {
      path = "";
      options = "--type small-spacer --section apps --after Discord";
    }
    {
      path = "";
      options = "--type small-spacer --section apps --after 1Password";
    }
    # Folders:
    {
      path = "/Users/${user}/Downloads/";
      section = "others";
      options = "--sort dateadded --view list --display stack";
    }
    {
      path = "/Users/${user}/coding/";
      section = "others";
      options = "--sort dateadded --view grid --display folder";
    }
  ];
}