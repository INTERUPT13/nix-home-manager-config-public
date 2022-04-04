
{
  description = "Home Manager configuration";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      username = "flandre";
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit system username;
        homeDirectory = "/home/${username}";
        stateVersion = "21.11";

        configuration = with import nixpkgs{inherit system;};{
          programs.neovim = {
            enable = true;
            viAlias = true;
            vimAlias = true;
            vimdiffAlias = true;
            plugins = with vimPlugins; [
              gruvbox-community
              vim-nix
            ];

            extraConfig = ''
              colorscheme gruvbox
            '';
          };

          programs.git.enable = true;
          programs.home-manager.enable = true;
        };

      };
    };
}
