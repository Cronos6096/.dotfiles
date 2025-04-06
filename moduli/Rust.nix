{pkgs, ...}:

{
  environment.systemPackages = with pkgs;  [
    rustc
    rustup
    rustfmt
    rustlings
    libgcc
    gcc_multi
    gcc
  ];
}
