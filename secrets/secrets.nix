{ pkgs, ... }:
let
  GiovanGianFranco = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICzLVu902On50CFbsm6hl6WsM3VDD1ooqeJC2im6QJh/";
in
{
  environment.systemPackages = with pkgs; [
    inputs.agenix.packages."${system}".default
    agenix-cli
  ];

  "secret1.age".publicKeys = [ GiovanGianFranco ];
}
