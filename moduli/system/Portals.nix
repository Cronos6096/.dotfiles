{ pkgs, ...}:
{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  xdg.menus.enable = true;         # Default: true :contentReference[oaicite:5]{index=5}
  xdg.mime.enable  = true;
}
