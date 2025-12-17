{
  enable = true;
  onActivation.autoUpdate = true;
  onActivation.upgrade = true;
  onActivation.cleanup = "zap";

  taps = [
    "nikitabobko/tap"
  ];

  brews = [
    "gh"
    "mas"
    "difftastic"
    "ruby-build" # https://github.com/rbenv/ruby-build/wiki#macos
    "mint"
    "ipython"
  ];

  casks = [
    "input-source-pro"
    "swiftformat-for-xcode"
    "tailscale-app"
    "visual-studio-code"
    "ghostty"
    # "raycast"
    "xcodes-app"
    "karabiner-elements"
    "openinterminal"
    "jordanbaird-ice"
    # "alt-tab"
    "fork"
    "lookin"
    "zed"
    "aerospace" # nikitabobko/tap

    "font-smiley-sans"
    "font-cascadia-code-pl"
    "font-caskaydia-cove-nerd-font"
    "font-maple-mono-nf-cn"
  ];

  masApps = {
    "Yoink" = 457622435;
    "Bob" = 1630034110;
    "Xnip" = 1221250572;
    "PasteNow" = 1552536109;
    "Elpass" = 1484823238;
  };
}
