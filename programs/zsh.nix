{ zsh-colored-man-pages, zsh-autosuggestions, zsh-clipboard-crossystem, ... }:
{ pkgs, ... }: {
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

    extraPackages = [ himalaya ];

    #extraConfig = ''
    #  colorscheme gruvbox
    #  lua << EOF\n'' + builtins.readFile ../nvim/nvim-init.lua + ''\nEOF'';

    # TODO clean up
    extraConfig =
      "\n          nnoremap <Left> :echo \"No left for you!\"<CR>\n          vnoremap <Left> :<C-u>echo \"No left for you!\"<CR>\n          inoremap <Left> <C-o>:echo \"No left for you!\"<CR>\n\n          nnoremap <Right> :echo \"No right  for you!\"<CR>\n          vnoremap <Right> :<C-u>echo \"No right for you!\"<CR>\n          inoremap <Right> <C-o>:echo \"No right for you!\"<CR>\n\n          nnoremap <Up> :echo \"No up for you!\"<CR>\n          vnoremap <Up> :<C-u>echo \"No up for you!\"<CR>\n          inoremap <Up> <C-o>:echo \"No up for you!\"<CR>\n\n          nnoremap <Down> :echo \"No down for you!\"<CR>\n          vnoremap <Down> :<C-u>echo \"No down for you!\"<CR>\n          inoremap <Down> <C-o>:echo \"No down for you!\"<CR>\n\n          noremap h n\n          noremap n h\n          noremap H N\n          noremap N H\n\n          noremap j e\n          noremap e j\n          noremap J E\n          noremap E J\n\n          noremap k o\n          noremap o k\n          nnoremap K O\n          nnoremap O K\n\n          noremap l i\n          noremap i l\n          noremap L I\n          noremap I L\n        "
      +

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

      "\n          colorscheme gruvbox\n          lua << EOF\n"
      + builtins.readFile ../nvim/nvim-init.lua + ''

        EOF'';

  };
}
