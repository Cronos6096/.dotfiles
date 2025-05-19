{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    nur.repos.novel2430.zen-browser-bin
  ];
}
