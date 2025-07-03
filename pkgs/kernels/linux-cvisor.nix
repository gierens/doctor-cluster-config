{ pkgs, ... }: rec {
  version = "6.12.0";
  modDirVersion = version;
  src = builtins.fetchGit {
    url = "file:///home/gierens/cvisor";
    rev = "b4e60708bd9a7b77be9ec9f01ff1df296c672725";
  };
  configfile = ./config-cvisor;
  linux = pkgs.linuxManualConfig {
    inherit version modDirVersion src configfile;
    allowImportFromDerivation = true;
  };
}
