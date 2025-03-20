{ buildLinux, fetchFromGitHub, ... }@args:
let
  buildKernel = { owner, repo, rev, sha256, version, modDirVersion, extraPatches ? [ ] }:
    buildLinux
      (args // rec {
        inherit version modDirVersion;

        src = fetchFromGitHub {
          inherit owner repo rev sha256;
        };

        kernelPatches = [
          {
            name = "pkvm-config";
            patch = null;
            extraConfig = ''
              KVM y
              KVM_INTEL y
              X86_64 y
              KSM n
              PKVM_INTEL y
              PKVM_INTEL_DEBUG y
              UNWINDER_ORC n
            '';
          }
        ] ++ extraPatches;
        extraMeta.branch = version;
        ignoreConfigErrors = true;
      } // (args.argsOverride or { }));

  intel_pkvm_6_2 = {
    owner = "intel-staging";
    repo = "pKVM-IA";
    # branch: RFC-v6.2
    rev = "0917307cfb9eb1063997fb1b490fe3cf21a6bbc3";
    sha256 = "sha256-4AN+WKg5HpuiWPE4kOtv8s1MujvU9+Ccp4E33DDyzPo=";
    version = "6.2";
    modDirVersion = "6.2.0";
  };
  intel_pkvm_6_11 = {
    owner = "intel-staging";
    repo = "pKVM-IA";
    # branch: RFC-v6.11
    rev = "62d13254298abebca8e83252cfdb759b8bddef46";
    sha256 = "sha256-0VKJO7bnP1fK2tbVcNPfIOF6T76THbTqi4pw/qHdW7M=";
    version = "6.11";
    modDirVersion = "6.11.0";
  };
  intel_pkvm_6_12 = {
    owner = "intel-staging";
    repo = "pKVM-IA";
    # branch: RFC-v6.12
    rev = "1070072c9e1cb919d7dc93bfc2ff6465e669cae8";
    sha256 = "sha256-4phTrXLw4Fc6gSwXZei9PSiaFjrDykyRRanfdzmoNlg=";
    version = "6.12";
    modDirVersion = "6.12.0";
  };
in
# change here to change kernel
buildKernel intel_pkvm_6_12
