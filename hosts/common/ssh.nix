{
  services.openssh.settings = {
    PermitRootLogin = "prohibit-password";
    IPQoS = "none";
  };
}
