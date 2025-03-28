{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nix-homebrew }:
  let
    configuration = { pkgs, ... }: {
      nix.channel.enable = false;
      nix.settings.experimental-features = "nix-command flakes";

      nixpkgs.config.allowUnfree = true;
      nixpkgs.hostPlatform = "aarch64-darwin";

      users.users."huanan" = {
    		name = "huanan";
    		home = "/Users/huanan";
    	};

      environment.systemPackages = [
        pkgs.vim
        pkgs.zplug
        pkgs.fzf
        pkgs.eza
        pkgs.lazygit
        pkgs.stow
        pkgs.mise
        pkgs.zoxide
        pkgs.zellij
      ];

      # https://daiderd.com/nix-darwin/manual/index.html
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;

      system.defaults.dock.show-recents = false;

      system.defaults.NSGlobalDomain = {
        InitialKeyRepeat = 25;
        KeyRepeat = 2;
      };

      # ~/Library/Preferences
      system.defaults.CustomUserPreferences = {
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

      programs.zsh = {
        enable = true;
      };

      # fonts
      fonts.packages = [
        pkgs.fira-code
        pkgs.nerd-fonts.jetbrains-mono
      ];

      # brew
      homebrew = {
        enable = true;
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
        onActivation.cleanup = "zap";

        brews = [
          "gh"
          "mas"
          "difftastic"
          "ruby-build" # https://github.com/rbenv/ruby-build/wiki#macos
        ];
        casks = [
          "tailscale"
		      "visual-studio-code"
		      "ghostty"
          "raycast"
          "xcodes"
          "karabiner-elements"
          "openinterminal"
          "jordanbaird-ice"
          "alt-tab"
          "fork"
          "lookin"
          "zed"

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
      };
    };
  in
  {
    darwinConfigurations."Huanans-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            enable = true;
            user = "huanan";
            autoMigrate = true;
          };
        }
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users."huanan" = import ./home.nix;
        }
      ];
    };
  };
}
