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
    user = "huanan";
    
    usersConf = {
      users.users."${user}" = {
        name = user;
        home = "/Users/${user}";
      };
    };

    configuration = { pkgs, ... }:
    {
      imports = [
        ./preferences.nix
      ];

      homebrew = import ./homebrew.nix;

      nix.channel.enable = false;
      nix.settings.experimental-features = "nix-command flakes";

      nixpkgs.config.allowUnfree = true;
      nixpkgs.hostPlatform = "aarch64-darwin";

      # https://daiderd.com/nix-darwin/manual/index.html
      system.primaryUser = user;
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;

      programs.zsh.enable = true;

      # https://search.nixos.org/packages
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
        pkgs.ripgrep
        pkgs.rustup
        pkgs.fd
        pkgs.uv
      ];
    };

    homeManagerConf = {
      imports = [ home-manager.darwinModules.home-manager ];

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users."${user}" = import ./home.nix;
    };

    homebrewConf = {
      imports = [ nix-homebrew.darwinModules.nix-homebrew ];

      nix-homebrew = {
        enable = true;
        inherit user;
        autoMigrate = true;
      };
    };
  in
  {
    darwinConfigurations."Huanans-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self; };
      modules = [
        usersConf
        configuration
        homebrewConf
        homeManagerConf
      ];
    };
    darwinConfigurations."Huanans-Mac-Studio" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self; };
      modules = [
        usersConf
        configuration
        homebrewConf
        homeManagerConf
      ];
    };
  };
}
