{pkgs, ...}:

{
  environment.systemPackages = with pkgs;  [
    rustc
    rustup
    rustfmt
    rustlings
    libgcc
  ];
}
