{ pkgs, lib, ... }:
let
  linux = pkgs.callPackage ../pkgs/kernels/linux-cvisor.nix { };
  linuxPackages = pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor linux.linux);
in
{
  boot.kernelPackages = lib.mkForce linuxPackages;
  boot.kernelParams = [
    "kvm-intel.pkvm=1"
  ];
}
