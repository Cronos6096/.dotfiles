let
  andme-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILxFBH7P8k6Y+98PIVPJXPtfSsQKYibO4QtIhwnVAGDb andme@GiovanGianFranco";
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
