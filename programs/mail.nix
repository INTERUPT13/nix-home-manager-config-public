{nix-home-manager-config-secrets,...}: 
{pkgs,...}: {
        programs.himalaya = {
          enable = true;
        };

        # each account needs a imap ={host,port,tls.enable}; and smtp={}; 
        # userName="", realName="", address="sth@domain.tld", and passwordCommand="";
        # i will keep these in a private config to not only avoid spam but also
        # for privacy reason. It kind of does not complain at the moment if you
        # are missing stuff so make sure you have everything configured and did not forget sth!!
        accounts.email.accounts = {
          r = {
            primary = true;
            himalaya = {
              enable = true;
              backend = "imap";
              sender = "smtp"; 
              #sender = "sendmail"; #if used on the mailserver itself?

            };
          } // import ("${nix-home-manager-config-secrets}/mail/creds_r.nix");
        };
}
