{pkgs, config, ...}: 

with pkgs; {

  programs.chromium = {
    enable = true;
    extensions = [
      "ahmkjjgdligadogjedmnogbpbcpofeeo" #the-great-suspender-original
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
    ];
  };


}
