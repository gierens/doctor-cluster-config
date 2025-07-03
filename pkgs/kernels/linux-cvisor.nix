{ pkgs, fetchFromGitHub, ... }: rec {
  version = "6.12.0";
  modDirVersion = version;
  # NOTE: this is faster if you have the repo available locally
  # src = builtins.fetchGit {
  #   url = "file:///home/gierens/cvisor";
  #   rev = "86c03f7dda4b91a1ec72c533eaee6b300bc2d48e";
  # };
  src = fetchFromGitHub {
    owner = "TUM-DSE";
    repo = "cvisor";
    rev = "86c03f7dda4b91a1ec72c533eaee6b300bc2d48e";
    hash = "sha256-Z4ZXvQNg8wbIl5tptzn6OLX7PWzUaj5fKIAo69WJZ58=";
  };
  configfile = ./config-cvisor;
  linux = pkgs.linuxManualConfig {
    inherit version modDirVersion src configfile;
    allowImportFromDerivation = true;
  };
}
