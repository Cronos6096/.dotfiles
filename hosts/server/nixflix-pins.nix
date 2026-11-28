{
  manifestHashes = {
    IAmParadox = "sha256-Idybc1kQxm/85FBVfh2zicR6cmzdattDJTw2mnCgmUs=";
    SeerrFin = "sha256-sd/o/GQaUr527SRoQYNFstDy3qXAcA64Uch9PCJ04po=";
    IntroSkipper = "sha256-weyxCtZOtMn8Ab6u3UJwBb/6hwbu/UucrZD7objqRhU=";
  };

  plugins = {
    "File Transformation" = {
      version = "3.0.3.0";
      url = "https://github.com/IAmParadox27/jellyfin-plugin-file-transformation/releases/download/3.0.3.0/Release-12.4.0.zip";
      hash = "sha256-L9GFSHvFZ3h4f6Lr6bYSwzen3fMZ/3ZHHhihF0a637E=";
    };
    "Intro Skipper" = {
      version = "12.0.8.0";
      url = "https://github.com/intro-skipper/intro-skipper/releases/download/12.0/v12.0.8.0/intro-skipper-v12.0.8.0.zip";
      hash = "sha256-33yHwBwTUpTI0Gjl9mh3JcFVibK5JNxeD3CCW4cGS6k=";
    };
    "SeerrFin" = {
      version = "1.9.6.0";
      url = "https://github.com/varunaditya-plus/SeerrFin/releases/download/1.9.6.0/Jellyfin.Plugin.SeerrFin_12.0.0.zip";
      hash = "sha256-YM6XB3x0XheuCLfeySnGA3a4Ve7J72j0gFcCi/YBDo0=";
    };
  };
}
