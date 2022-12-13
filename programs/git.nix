{ pkgs, config, ... }:

with pkgs; {
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "flandre";
    userEmail = "flandre@no.where";

    extraConfig = { color.ui = "auto"; };
  };
}
