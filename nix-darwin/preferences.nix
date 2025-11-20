{
  dock.show-recents = false;

  NSGlobalDomain = {
    InitialKeyRepeat = 25;
    KeyRepeat = 2;
  };

  # ~/Library/Preferences
  # https://github.com/yannbertrand/macos-defaults
  CustomUserPreferences = {
    "com.apple.Safari" = {
      SearchProviderShortName = "Google";
      IncludeDevelopMenu = true;
      WebKitDeveloperExtrasEnabledPreferenceKey = true;
    };

    "com.apple.symbolichotkeys" = {
      AppleSymbolicHotKeys = {
        "60" = {
          enabled = false;
        };
        "61" = {
          enabled = false;
        };
      };
    };
  };
}

