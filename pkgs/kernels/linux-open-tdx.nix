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
            name = "open-tdx-config";
            patch = null;
            extraConfig = ''
              KVM_SW_PROTECTED_VM y
              KVM_GENERIC_PRIVATE_MEM y
              SYSTEM_TRUSTED_KEYS y
              SYSTEM_REVOCATION_KEYS y
              DRM_AMDGPU n
              DRM_NOUVEAU n
            '';
          }
          # NOTE: only needed prior to 6.9
          # {
          #   name = "bug_func export";
          #   patch = ./zfs-tdx.patch;
          #   extraConfig = '''';
          # }
        ] ++ extraPatches;
        extraMeta.branch = version;
        ignoreConfigErrors = true;
      } // (args.argsOverride or { }));

  open_tdx_6_8 = {
    owner = "sslab-gatech";
    repo = "tdx-linux";
    # branch: opentdx-host
    rev = "fe61e02ba4eed7b193d9f4578614732cc6f34055";
    sha256 = "sha256-0mplbhGEBmkpiBQhrYn5YBHW135DzeLnEEstrVCnbTY=";
    version = "6.8";
    modDirVersion = "6.8.0";
  };
in
# change here to change kernel
buildKernel open_tdx_6_8
