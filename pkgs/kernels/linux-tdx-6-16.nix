{ pkgs, fetchFromGitHub, ... }: rec {
  version = "6.16.2";
  modDirVersion = version;
  src = fetchFromGitHub {
    owner = "gierens";
    repo = "linux";
    rev = "25bf10be219d37d2fb221c93816a913f5f735530";
    sha256 = "sha256-O5uOLPTmMKuXkjZGFZ5VufmpYPGl0pOditfBoM9aGM8=";
  };
  configfile = ./config-tdx-6-16;
  linux = pkgs.linuxManualConfig {
    inherit version modDirVersion src configfile;
    allowImportFromDerivation = true;
  };
}
