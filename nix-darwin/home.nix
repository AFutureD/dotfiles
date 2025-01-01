{ config, pkgs, ... }:

{
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.starship
  ];

  programs.zsh = {
    enable = true;

    initExtra = ''
      zstyle ':completion:*:descriptions' format '[%d]'
      zstyle ':fzf-tab:*' continuous-trigger '/'
    '';

    localVariables = {
      XDG_CONFIG_HOME = "$HOME/.config";
    };

    shellAliases = {
      ls = "eza";
      lst = "ls -T -L 2";
      ll = "ls -abhlG --time-style=relative --git --group-directories-first --octal-permissions --no-user";
      lz = "lazygit";
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