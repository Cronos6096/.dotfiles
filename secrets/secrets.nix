let
  andme-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILxFBH7P8k6Y+98PIVPJXPtfSsQKYibO4QtIhwnVAGDb andme@GiovanGianFranco";
  # andme-pi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMCaseVWWKedBfcXAEUR2TR9CCGvmqWkzb4IRSVdJGyv";
  users = [
    andme-laptop
    # andme-pi
  ];
in
{
  "env.age".publicKeys = users;
  "password.age".publicKeys = users;
  # "server.age".publicKeys = users ++ systems;
}
