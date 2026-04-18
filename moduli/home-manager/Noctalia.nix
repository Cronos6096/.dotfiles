{ lib, config, ... }:
with lib;
{
  config = mkIf config.moduli.home-manager.noctalia.enable {
    stylix.targets.noctalia-shell.enable = true;

    programs.noctalia-shell = {
      enable = true;
      settings = {
        settingsVersion = 0;

        bar = {
          position = "top";
          monitors = [ ];
          density = "default";
          showOutline = false;
          showCapsule = true;
          capsuleOpacity = mkForce 0.9;
          backgroundOpacity = mkForce 0.0;
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
                useDistroLogo = true;
              }
              {
                id = "Workspace";
                labelMode = "none";
                hideUnoccupied = true;
                showApplications = true;
              }
              {
                id = "ActiveWindow";
                maxWidth = 450;
              }
            ];
            center = [
              {
                id = "Clock";
                formatHorizontal = "HH:mm:ss";
                useMonospacedFont = true;
                tooltipFormat = "yyyy-MM-dd ddd";
              }
            ];
            right = [
              {
                id = "MediaMini";
                hideMode = "hidden";
                maxWidth = 450;
              }
              {
                defaultSettings = {
                  camFilterRegex = "";
                  enableToast = true;
                  hideInactive = false;
                  iconSpacing = 4;
                  micFilterRegex = "";
                  removeMargins = false;
                };
                id = "plugin:privacy-indicator";
              }
              {
                defaultSettings = { };
                id = "plugin:kde-connect";
              }
              {
                blacklist = [
                  "KDE*"
                ];

                chevronColor = "none";
                colorizeIcons = true;
                drawerEnabled = false;
                hidePassive = false;
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
                alwaysShowPercentage = true;
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
          lockScreenAnimations = true;
          enableLockScreenMediaControls = false;
          enableShadows = false;
          telemetryEnabled = false;
        };

        ui = {
          fontDefault = mkForce "JetBrains Mono Nerd Fonts";
          fontFixed = mkForce "JetBrains Mono Nerd Fonts";
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

        sessionMenu = {
          enableCountdown = true;
          countdownDuration = 3000;
          position = "center";
          showHeader = true;
          showKeybinds = false;
          largeButtonsStyle = true;
          largeButtonsLayout = "single-row";
          powerOptions = [
            {
              action = "lock";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "1";
            }
            {
              action = "shutdown";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "2";
            }
            {
              action = "logout";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "3";
            }
          ];
        };

        plugins = {
          autoUpdate = true;
          notifyUpdates = false;
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
  };
}
