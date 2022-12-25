{ pkgs, ... }:
with pkgs; [
  #alacritty
  rxvt-unicode
  gnome.nautilus
  blackbox-terminal
  #gnome.console
  cowsay


  #TODO make a server config like pinephone home manager config so the server doesn't get all that desktop shit
]
