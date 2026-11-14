{
  manifestHashes = {
    IAmParadox = "sha256-Idybc1kQxm/85FBVfh2zicR6cmzdattDJTw2mnCgmUs=";
    SeerrFin = "sha256-cSdRtxI8t//+dyCUT+916LKC/Itu4pZLxeZLB69CBYs=";
    IntroSkipper = "sha256-OE2mDp8H9ZzZ7hnUpCdO0s1k9r0gPRAIPBGuy4UaH3U=";
  };

  plugins = {
    "File Transformation" = {
      version = "3.0.3.0";
      url = "https://github.com/IAmParadox27/jellyfin-plugin-file-transformation/releases/download/3.0.3.0/Release-12.4.0.zip";
      hash = "sha256-L9GFSHvFZ3h4f6Lr6bYSwzen3fMZ/3ZHHhihF0a637E=";
    };
    "Intro Skipper" = {
      version = "12.0.6.0";
      url = "https://github.com/intro-skipper/intro-skipper/releases/download/12.0/v12.0.6.0/intro-skipper-v12.0.6.0.zip";
      hash = "sha256-pOnqTVfpcqPLctqTwwd2MC3XtFI3Vy8aAQ9T7CFoey8=";
    };
    "SeerrFin" = {
      version = "1.9.4.0";
      url = "https://github.com/varunaditya-plus/SeerrFin/releases/download/1.9.4.0/Jellyfin.Plugin.SeerrFin_12.0.0.zip";
      hash = "sha256-z8STAHLo/3Axera2x2o/0NhXilGh/gPpASuupaFCOS4=";
    };
  };
}
