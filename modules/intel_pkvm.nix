{ pkgs, lib, ... }:
let
  linux = pkgs.callPackage ../pkgs/kernels/linux-pkvm.nix { };
  linuxPackages = pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor linux);
in
{
  boot.kernelPackages = lib.mkForce linuxPackages;
  # boot.zfs.package = pkgs.zfsUnstable; # needed for 6.9

  boot.kernelParams = [ ];

  # enable libvirtd service
  virtualisation.libvirtd.enable = true;
}
