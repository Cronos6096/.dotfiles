{
  programs.noctalia-shell = {
    enable = true;
    settings = {
      settingsVersion = 0;

      bar = {
        position = "top";
        monitors = [ ];
        density = "confortable";
        showOutline = false;
        showCapsule = true;
        capsuleOpacity = 0.9;
        backgroundOpacity = 0.0;
        useSeparateOpacity = true;
        floating = false;
        marginVertical = 4;
        marginHorizontal = 4;
        outerCorners = false;
        exclusive = true;
        hideOnOverview = false;
        widgets = {
          left = [
            {
              id = "ControlCenter";
            }
            {
              id = "Workspace";
            }
            {
              id = "ActiveWindow";
            }
          ];
          center = [
            {
              id = "Clock";
            }
          ];
          right = [
            {
              id = "MediaMini";
            }
            {
              id = "Tray";
            }
            {
              id = "NotificationHistory";
            }
            {
              id = "Brightness";
            }
            {
              id = "Volume";
            }
            {
              id = "Battery";
            }
          ];
        };
      };

      general = {
        avatarImage = "/home/andme/Pictures/pfp.jpg";
        dimmerOpacity = 0.5;
        showScreenCorners = false;
        forceBlackScreenCorners = false;
        scaleRatio = 1.05;
        radiusRatio = 1;
        iRadiusRatio = 1;
        boxRadiusRatio = 1;
        screenRadiusRatio = 1;
        animationSpeed = 1;
        animationDisabled = false;
        compactLockScreen = false;
        lockOnSuspend = true;
        showSessionButtonsOnLockScreen = true;
        showHibernateOnLockScreen = false;
        enableShadows = false;
        telemetryEnabled = false;
      };

      ui = {
        fontDefault = "JetBrains Mono Nerd Fonts";
        fontFixed = "JetBrains Mono Nerd Fonts";
        fontDefaultScale = 1;
        fontFixedScale = 1;
        tooltipsEnabled = true;
        panelsAttachedToBar = true;
        settingsPanelMode = "attached";
        wifiDetailsViewMode = "grid";
        bluetoothDetailsViewMode = "grid";
        networkPanelView = "wifi";
        bluetoothHideUnnamedDevices = false;
        boxBorderEnabled = false;
      };

      location = {
        name = "Rome";
        showWeekNumberInCalendar = true;
        hideWeatherCityName = true;
      };

      wallpaper = {
        enabled = false;
      };

      controlCenter = {
        position = "close_to_bar_button";
        diskPath = "/";
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "audio-card";
          }
          {
            enabled = false;
            id = "brightness-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
        ];
      };

      dock = {
        floatingRatio = 1.25;
        size = 1.25;
      };

      sessionMenu = {
        enableCountdown = true;
        countdownDuration = 10000;
        position = "center";
        showHeader = true;
        largeButtonsStyle = true;
        largeButtonsLayout = "grid";
        showNumberLabels = true;
        powerOptions = [
          {
            action = "shutdown";
            enabled = true;
          }
          {
            action = "reboot";
            enabled = true;
          }
          {
            action = "logout";
            enabled = true;
          }
        ];
      };

      notifications = {
        location = "bottom";
      };

      osd = {
        location = "bottom";
      };

      audio = {
        volumeStep = 1;
        volumeOverdrive = true;
        cavaFrameRate = 60;
      };

      colorSchemes = {
        useWallpaperColors = true;
      };

      nightLight = {
        enabled = true;
        forced = false;
        autoSchedule = true;
        nightTemp = "5500";
        dayTemp = "6500";
      };
    };
  };
}
