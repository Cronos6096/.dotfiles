let
  andme-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE0eWmYUr3u6FFhpv5Zj6LlcQIm8O4ZSJiZkuOtVM9NL andme@GiovanGianFranco";
  andme-pi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE/06jWRdLOoCwgUk5SpMubBitLY4TMHZNvmushyv/30 andme@rpi5";
  users = [
    andme-laptop
    andme-pi
  ];
in
{
  "env.age".publicKeys = users;
  "password.age".publicKeys = users;
  "duckdnsToken.age".publicKeys = users;
}
