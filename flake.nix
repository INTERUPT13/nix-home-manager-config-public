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

    nixfmt = {
      url = "https://github.com/serokell/nixfmt";
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

  outputs = { nixpkgs, home-manager, zsh-colored-man-pages, zsh-autosuggestions
    , zsh-clipboard-crossystem, nixfmt, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      homeConfigurations.flandre = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = with pkgs; [{
          home = {
            username = "flandre";
            homeDirectory = "/home/flandre";
            stateVersion = "21.11";

            packages = [
              htop
              tmux
              nixfmt.packages.x86_64-linux.nixfmt
            ];
          };
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

          programs.neovim = with pkgs; {
            enable = true;
            viAlias = true;
            vimAlias = true;
            vimdiffAlias = true;
            plugins = with vimPlugins; [ gruvbox-community vim-nix ];

            extraConfig = ''
              colorscheme gruvbox
            '';
          };

          programs.git = {
            enable = true;
            userName = "flandre";
            userEmail = "flandre@dontspamme.com";
          };

          programs.home-manager.enable = true;
        }];
      };
    };
}
