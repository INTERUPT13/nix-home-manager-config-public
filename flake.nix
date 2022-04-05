
{
  description = "Home Manager configuration";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    zsh-colored-man-pages = {
      url = "https://github.com/ael-code/zsh-colored-man-pages";
      flake = false;
      type = "git";
    };

    zsh-autosuggestions = {
      url = "https://github.com/zsh-users/zsh-autosuggestions";
      flake = false;
      type = "git";
    };

    zsh-clipboard-crossystem = {
      url = "https://github.com/zpm-zsh/clipboard";
      flake = false;
      type = "git";
    };
  };

  outputs = { nixpkgs, home-manager, zsh-colored-man-pages, zsh-autosuggestions, 
    zsh-clipboard-crossystem, ...}:
    let
      system = "x86_64-linux";
      username = "flandre";
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit system username;
        homeDirectory = "/home/${username}";
        stateVersion = "21.11";

        configuration = with import nixpkgs{inherit system;};{
          programs.zsh = {
            enable = true;
            enableCompletion = true;
            oh-my-zsh = {
              enable = true;
              theme = "eastwood";
            };
            plugins = [
              {
                name = "zsh-colored-man-pages";
                src = zsh-colored-man-pages;
              }
              {
                name = "zsh-autosuggestions";
                src = zsh-autosuggestions;
              }
              #TODO V broken
              {
                name = "zsh-clipboard-crossystem";
                src = zsh-clipboard-crossystem;
              }
            ];
          };

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
