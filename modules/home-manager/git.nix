{
  programs.git = {
    enable = true;
    lfs = { enable = true; };
    userEmail = "jason.prado@gmail.com";
    userName = "Jason Prado";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      rebase.autoStash = true;
    };
  };
}
