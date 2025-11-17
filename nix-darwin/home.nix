# https://nix-community.github.io/home-manager/options.xhtml

{ config, pkgs, ... }:

{
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.starship
  ];

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.sessionVariables = {
    EDITOR = "code";
  };

  xdg.enable = true;

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;

    initContent = ''
      autoload -U up-line-or-beginning-search
      autoload -U down-line-or-beginning-search
      zle -N up-line-or-beginning-search
      zle -N down-line-or-beginning-search
      bindkey "^[[A" up-line-or-beginning-search
      bindkey "^[[B" down-line-or-beginning-search

      zstyle ':completion:*:descriptions' format '[%d]'
      zstyle ':fzf-tab:*' continuous-trigger '/'

      export TERM=xterm-256color
    '';

    localVariables = {
      HOMEBREW_NO_ENV_HINTS = true;
      HOMEBREW_NO_AUTO_UPDATE = true;
      HOMEBREW_NO_AUTO_UPDAT = true;
      HOMEBREW_BUNDLE_NO_UPGRADE = true;
    };

    shellAliases = {
      ls = "eza -bhl --time-style=relative --git --group-directories-first --octal-permissions --no-user";
      lst = "ls -T -L 2";
      ll = "eza -abhl --time-style=relative --git --group-directories-first --octal-permissions --no-user";
      lz = "lazygit";
      ir = "iredis --rainbow --newbie --decode=utf8";
      zja = "zellij attach -c";
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

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship.enable = true;

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    # attachExistingSession = true;
    # exitShellOnExit = true;
  };
}
