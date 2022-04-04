# nix-home-manager-config-public

instaled (21.11) via

```sh
  nix-channel --add https://github.com/nix-community/home-manager/archive/release-21.11.tar.gz home-manager
  nix-channel --update

  export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
 
    nix-shell '<home-manager>' -A install


  echo . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" > ~/.profile


  nix build --no-link ~/.config.nixpklgs#homeConfigurations.flandre.activationPackage

  # (note: if I run into weird activation package missing issues again ... make sure that the usename
  # for  nixpkgs#homeConfigurations.<username>.... is correct in the .config/nixpkgs/flake.nix 
```
