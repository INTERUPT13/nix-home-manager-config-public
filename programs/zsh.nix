{zsh-colored-man-pages, zsh-autosuggestions, zsh-clipboard-crossystem,...}:
{pkgs,...}: {
        programs.zsh = {
          enable = true;
          enableCompletion = true;
          enableSyntaxHighlighting = true;
          envExtra = "EDITOR=nvim";

          # why doesn't this work but above?
          #sessionVariables = {
          #  EDITOR = "nvim";
          #};
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
}
