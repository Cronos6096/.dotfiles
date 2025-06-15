{ inputs, pkgs, ... }: {
  imports = [ inputs.zen-browser.homeModules.beta ];
  programs.zen-browser = {
    enable = true;
    # policies = {
    #   DisableAppUpdate = true;
    #   DisableTelemetry = true;
    #   AutofillAddressEnabled = false;
    #   AutofillCreditCardEnabled = false;
    #   DisableFeedbackCommands = true;
    #   DisableFirefoxStudies = true;
    #   DontCheckDefaultBrowser = true;
    #   OfferToSaveLogins = false;
    # };
    # nativeMessagingHosts = [ pkgs.firefoxpwa ];
  };
}
