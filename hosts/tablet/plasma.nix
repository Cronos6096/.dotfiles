{
  pkgs,
  lib,
  ...
}:
let
  deStart = pkgs.writeShellScript "de-start" ''
    set -u
    ENV_FILE=/run/droidspaces.env
    XSOCK=/tmp/.X11-unix/X5
    XFCE_USER=andme
    RUNTIME_DIR=/run/user/1000
    DE_CMD=startplasma-x11
    NC=${pkgs.libressl.nc}/bin/nc
    TIMEOUT=${pkgs.coreutils}/bin/timeout

    if [ -f "$ENV_FILE" ]; then
        while IFS= read -r line; do
            case "$line" in
                export\ *) export "$(printf '%s' "$line" | sed 's/^export //')" ;;
            esac
        done <"$ENV_FILE"
    fi

    export DISPLAY=''${DISPLAY:-:5}

    loginctl enable-linger "$XFCE_USER" || true

    su_args="-l"

    wait_for_x() {
        while :; do
            if [ -S "$XSOCK" ] && "$TIMEOUT" 2 "$NC" -U -z "$XSOCK" >/dev/null 2>&1; then
                return 0
            fi
            sleep 2
        done
    }

    start_de() {
        su_prefix="export XDG_RUNTIME_DIR=$RUNTIME_DIR DBUS_SESSION_BUS_ADDRESS=unix:path=$RUNTIME_DIR/bus DISPLAY=$DISPLAY QT_XCB_GL_INTEGRATION=none; export PATH=/run/current-system/sw/bin:\$PATH; systemctl --user set-environment DISPLAY=$DISPLAY QT_QPA_PLATFORM=xcb QT_XCB_GL_INTEGRATION=none XDG_RUNTIME_DIR=$RUNTIME_DIR DBUS_SESSION_BUS_ADDRESS=unix:path=$RUNTIME_DIR/bus; exec $DE_CMD"
        su $su_args "$XFCE_USER" -s ${pkgs.bash}/bin/bash -c "$su_prefix"
    }

    while :; do
        wait_for_x
        su $su_args "$XFCE_USER" -s ${pkgs.bash}/bin/bash -c '${lockSetup}'
        start_de
        sleep 3
    done
  '';

  lockSetup = pkgs.writeShellScript "de-lock-setup" ''
    export XDG_RUNTIME_DIR=/run/user/1000 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus HOME=/home/andme
    ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file kscreenlockerrc --group Daemon --key Autolock false || true
    ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file kscreenlockerrc --group Daemon --key LockOnResume false || true
    ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file kscreenlockerrc --group Daemon --key Timeout 0 || true
    ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file ksmserverrc --group General --key loginMode emptySession || true
  '';

in
{
  security.pam.services.su.startSession = true;

  services.desktopManager.plasma6.enable = true;

  services.fwupd.enable = false;
  services.geoclue2.enable = false;
  services.power-profiles-daemon.enable = false;
  services.accounts-daemon.enable = lib.mkForce false;
  services.pipewire.enable = false;
  services.udisks2.enable = lib.mkForce false;
  services.orca.enable = false;

  systemd.defaultUnit = "graphical.target";

  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin/de-start - - - - ${deStart}"
  ];

  systemd.services.de-autostart = {
    description = "Desktop Environment Autostart (X11)";
    after = [ "graphical.target" ];
    wantedBy = [ "graphical.target" ];
    serviceConfig = {
      Type = "simple";
      ExecCondition = [
        "${pkgs.bash}/bin/sh -c 'grep -q \"enable_termux_x11=1\" /run/droidspaces/container.config'"
      ];
      ExecStart = "${deStart}";
    };
  };
}
