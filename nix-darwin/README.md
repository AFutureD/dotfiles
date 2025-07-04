1. install Nix by https://github.com/DeterminateSystems/nix-installer
2. nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/Dotfiles/nix-darwin
3. sudo stow nix-darwin -t /etc/nix-darwin
4. darwin-rebuild switch --option access-tokens "<GITHUB_ACCESS_TOKEN>"

update flake
> nix flake update --option access-tokens "<GITHUB_ACCESS_TOKEN>"
