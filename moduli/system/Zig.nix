{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    zig
    zig-shell-completions

    # Librerie

    gmp
  ];
}
