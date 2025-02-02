# https://nix-community.github.io/home-manager/options.xhtml

{ config, pkgs, ... }:

{
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.starship
  ];

  xdg.enable = true;

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;

    initExtra = ''
      zstyle ':completion:*:descriptions' format '[%d]'
      zstyle ':fzf-tab:*' continuous-trigger '/'
    '';

    localVariables = {
      HOMEBREW_NO_AUTO_UPDATE = "true";
    };

    shellAliases = {
      ls = "eza -bhl --time-style=relative --git --group-directories-first --octal-permissions --no-user";
      lst = "ls -T -L 2";
      ll = "eza -abhl --time-style=relative --git --group-directories-first --octal-permissions --no-user";
      lz = "lazygit";
      ir = "iredis --rainbow --newbie --decode=utf8";
    };

    zplug = {
      enable = true;

      plugins = [
        { name = "Aloxaf/fzf-tab"; }
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
      ];
    };
  };

  programs.starship.enable = true;
}