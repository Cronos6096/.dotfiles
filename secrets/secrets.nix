let
  andme-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE0eWmYUr3u6FFhpv5Zj6LlcQIm8O4ZSJiZkuOtVM9NL andme@GiovanGianFranco";
  andme-pi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICLgTPf6BuE5WHkZvk/pbrJNJ3d8icQ5BAHAaNADBrji andme@rpi5";
  users = [
    andme-laptop
    andme-pi
  ];
in
{
  "password.age".publicKeys = users;
  "duckdnsToken.age".publicKeys = users;

  "nixflix/sonarr-api-key.age".publicKeys = users;
  "nixflix/sonarr-password.age".publicKeys = users;
  "nixflix/radarr-api-key.age".publicKeys = users;
  "nixflix/radarr-password.age".publicKeys = users;
  "nixflix/prowlarr-api-key.age".publicKeys = users;
  "nixflix/prowlarr-password.age".publicKeys = users;
  "nixflix/jellyfin-api-key.age".publicKeys = users;
  "nixflix/jellyfin-admin-password.age".publicKeys = users;
  "nixflix/seerr-api-key.age".publicKeys = users;
  "nixflix/rtorrent-username.age".publicKeys = users;
  "nixflix/rtorrent-password.age".publicKeys = users;
  "nixflix/qbittorrent-password.age".publicKeys = users;
}
