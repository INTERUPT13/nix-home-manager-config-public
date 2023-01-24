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



        # for various language servers
        home.packages = with pkgs; [
            rnix-lsp
            luaPackages.lua-lsp


            nodePackages.vscode-json-languageserver-bin
            nodePackages.vscode-html-languageserver-bin
            nodePackages.vscode-css-languageserver-bin

        ];

        # TODO move in own file
        programs.neovim = with pkgs; {
          enable = true;
          viAlias = true;
          vimAlias = true;
          vimdiffAlias = true;
          plugins = with vimPlugins; [ 
            gruvbox-community
            vim-nix
            himalaya-vim
            vim-markdown


            #nodePackages.rust-languageserver

            rust-tools-nvim
            nvim-lspconfig
            vimPlugins.lsp_extensions-nvim

          ];

          extraPackages = [
            himalaya
          ];


          #extraConfig = ''
          #  colorscheme gruvbox
          #  lua << EOF\n'' + builtins.readFile ../nvim/nvim-init.lua + ''\nEOF'';

          # TODO clean up
          extraConfig = "
          nnoremap <Left> :echo \"No left for you!\"<CR>
          vnoremap <Left> :<C-u>echo \"No left for you!\"<CR>
          inoremap <Left> <C-o>:echo \"No left for you!\"<CR>

          nnoremap <Right> :echo \"No right  for you!\"<CR>
          vnoremap <Right> :<C-u>echo \"No right for you!\"<CR>
          inoremap <Right> <C-o>:echo \"No right for you!\"<CR>

          nnoremap <Up> :echo \"No up for you!\"<CR>
          vnoremap <Up> :<C-u>echo \"No up for you!\"<CR>
          inoremap <Up> <C-o>:echo \"No up for you!\"<CR>

          nnoremap <Down> :echo \"No down for you!\"<CR>
          vnoremap <Down> :<C-u>echo \"No down for you!\"<CR>
          inoremap <Down> <C-o>:echo \"No down for you!\"<CR>

          noremap h n
          noremap n h
          noremap H N
          noremap N H

          noremap j e
          noremap e j
          noremap J E
          noremap E J

          noremap k o
          noremap o k
          nnoremap K O
          nnoremap O K

          noremap l i
          noremap i l
          noremap L I
          noremap I L
        " + 


    #--nnoremap l o
    #--!nnoremap o l
    #--!nnoremap L O
    #--!nnoremap O L
    #--!nnoremap j n
    #--!nnoremap n j
    #--!nnoremap J N
    #--!nnoremap N J
    #--!nnoremap gn gj
    #--!nnoremap gj gn
    #--!nnoremap k e
    #--!nnoremap e k
    #--!nnoremap K E
    #--!nnoremap E <nop>
    #--!nnoremap gk ge
    #--!nnoremap ge gk
    #--!nnoremap h y
    #--!onoremap h y
    #--!nnoremap y h
    #--!nnoremap H Y
    #--!nnoremap Y H

    "
          colorscheme gruvbox
          lua << EOF\n" + builtins.readFile ../nvim/nvim-init.lua + "\nEOF";

        };
}
