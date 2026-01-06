let
  andme-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILxFBH7P8k6Y+98PIVPJXPtfSsQKYibO4QtIhwnVAGDb andme@GiovanGianFranco";
  users = [
    andme-laptop
  ];
in
{
  "env.age".publicKeys = users;
}
