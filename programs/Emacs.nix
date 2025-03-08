{config, pkgs, ... }:

{
  programs.emacs = { enable = true; };
  environment.systemPackages = with pkgs; [
    ## Emacs itself
    binutils # native-comp needs 'as', provided by this
    emacs # HEAD + native-comp

    ## Doom dependencies
    git
    ripgrep
    gnutls # for TLS connectivity

    ## Optional dependencies
    fd # faster projectile indexing
    imagemagick # for image-dired
    (mkIf (config.programs.gnupg.agent.enable)
      pinentry-emacs) # in-emacs gnupg prompts
    zstd # for undo-fu-session/undo-tree compression

    ## Module dependencies
    # :email mu4e
    mu
    isync
    # :checkers spell
    (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
    # :tools editorconfig
    editorconfig-core-c # per-project style config
    # :tools lookup & :lang org +roam
    sqlite
    # :lang cc
    clang-tools
    # :lang latex & :lang org (latex previews)
    texlive.combined.scheme-medium
    # :lang beancount
    beancount
    fava
    # :lang nix
    age
  ];

  environment.variables.PATH = [ "$XDG_CONFIG_HOME/emacs/bin" ];
  fonts.packages =
    [ (pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; }) ];
}
