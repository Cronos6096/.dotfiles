{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pyright

    (python3.withPackages (
      ps: with ps; [
        wheel
        matplotlib
        requests
      ]
    ))
  ];
}
