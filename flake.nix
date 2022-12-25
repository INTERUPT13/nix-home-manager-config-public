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

    nix-home-manager-config-secrets = {
      url = "git+ssh://git@github.com/INTERUPT13/nix-home-manager-config-secrets";
      type = "git";
      #url = "path:/etc/nixos/nix-home-manager-config-secrets";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, zsh-colored-man-pages
    , zsh-autosuggestions, zsh-clipboard-crossystem, nixfmt, nix-home-manager-config-secrets, ... }@attrs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      # TODO make this passable from the outside via ? operator
      phonepkgs = import nixpkgs { system = "aarch64-linux"; };
    in {
      # to be used with the nixos home-manager module + standalone home-manager
      # TODO make this one desktop the default one shall be more lightweight and
      # more aimed at useful sysadmin tools + nvim
      pinephone_cfg = with phonepkgs; {
        home = {
          stateVersion = "22.11";

          # TODO secrets management for every program that needs secrets
          packages = with phonepkgs;
            [
              tdesktop # sinke kotatogram or how its called seems to not run on aarch or whatever

            ] ++ (import ./packages/multimedia.nix (phonepkgs))
            ++ (import ./packages/social.nix (pkgs))
            #++ (import ./packages/web.nix (pkgs))
            #++ (import ./packages/crypto.nix (pkgs))
            ++ (import ./packages/linux_tools.nix (phonepkgs))
            ++ (import ./packages/nix_tools.nix (phonepkgs))
            #++ (import ./packages/binary_debugging.nix (pkgs))
            #TODO make "rr" free version for aarch64 ++ (import ./packages/security.nix (phonepkgs))
            ++ (import ./packages/terminal.nix (phonepkgs))
            ++ (import ./packages/doc_creation.nix (phonepkgs))
            ++ (import ./packages/remote_access.nix (phonepkgs));
        };

        #imports = [ ./programs/chromium.nix ];
        imports = [ ./programs/git.nix ];


        programs.neovim = with phonepkgs; {
          enable = true;
          viAlias = true;
          vimAlias = true;
          vimdiffAlias = true;
          plugins = with vimPlugins; [ gruvbox-community vim-nix ];

          extraConfig = ''
            colorscheme gruvbox
          '';
        };



        programs.home-manager.enable = true;  

      } // (import ./programs/zsh.nix attrs)
      // (import ./programs/mail.nix {inherit nix-home-manager-config-secrets;});

      server_cfg = with pkgs; {
        home = {
          stateVersion = "22.05";

          # TODO secrets management for every program that needs secrets
          packages = with pkgs;
            [ ] 
            ++ (import ./packages/linux_tools.nix (pkgs))
            ++ (import ./packages/nix_tools.nix (pkgs))
            ++ (import ./packages/binary_debugging.nix (pkgs))
            ++ (import ./packages/security.nix (pkgs))
            ++ (import ./packages/remote_access.nix (pkgs));
        };

        imports = [ ./programs/chromium.nix ./programs/git.nix ];


        programs.home-manager.enable = true;

      } // (import ./programs/zsh.nix attrs)
      // (import ./programs/mail.nix {inherit nix-home-manager-config-secrets;});

      default_cfg = with pkgs; {
        home = {
          stateVersion = "22.05";

          # TODO secrets management for every program that needs secrets
          packages = with pkgs;
            [ ] ++ (import ./packages/multimedia.nix (pkgs))
            ++ (import ./packages/social.nix (pkgs))
            ++ (import ./packages/web.nix (pkgs))
            ++ (import ./packages/crypto.nix (pkgs))
            ++ (import ./packages/linux_tools.nix (pkgs))
            ++ (import ./packages/nix_tools.nix (pkgs))
            ++ (import ./packages/binary_debugging.nix (pkgs))
            ++ (import ./packages/security.nix (pkgs))
            ++ (import ./packages/remote_access.nix (pkgs))
            ++ (import ./packages/shader_dev.nix (pkgs));
        };

        imports = [ ./programs/chromium.nix ./programs/git.nix ];


        programs.home-manager.enable = true;

      } // (import ./programs/zsh.nix attrs)
      // (import ./programs/mail.nix {inherit nix-home-manager-config-secrets;});

      # applied when using home manager standalone for user flandre
      #homeConfigurations.flandre =  home-manager.lib.homeManagerConfiguration ( self.default_cfg );
      homeConfigurations.flandre = with pkgs;
        home-manager.lib.homeManagerConfiguration ({
          inherit pkgs;
          modules = [
            {
              home.username = "flandre";
              home.homeDirectory = "/home/flandre";
            }
            self.default_cfg

          ];
        });
    };
}
