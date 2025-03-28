{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (pkgs.python3.withPackages (python-pkgs:
      with python-pkgs; [
        pandas
        requests
        python312Packages.pip
        python312Packages.numpy
        python312Packages.matplotlib
        python312Packages.termplotlib
      ]))
  ];
}
