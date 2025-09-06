{ pkgs, lib, ... }:
let
  linux = pkgs.callPackage ../pkgs/kernels/linux-tdx-6-16.nix { };
  linuxPackages = pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor linux.linux);
in
{
  boot.zfs.package = lib.mkForce pkgs.zfsUnstable;
  boot.kernelPackages = lib.mkForce linuxPackages;
  boot.kernelParams = [
    "kvm_intel.tdx=1"
  ];
}
