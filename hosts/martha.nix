{
  imports = [
    ../modules/hardware/poweredge-r770.nix
    ../modules/nfs/client.nix
    ../modules/disko-zfs.nix
    # Fails to build amdgpu module
    # ../modules/intel_tdx.nix
    ../modules/linux-cvisor.nix

    ../modules/vfio/iommu-intel.nix
    ../modules/dpdk.nix
    # ../modules/zokelmannvms.nix # ZFS pool import fails currently
  ];

  networking.hostName = "martha";

  # Configuration for zokelmannvms module (when enabled)
  # services.zokelmannvms.partitionUuid = "8523992b-aa9b-4d77-b23b-4ab0b20f0de4";

  disko.rootDisk = "/dev/disk/by-id/nvme-SAMSUNG_MZQL23T8HCLS-00A07_S64HNJ0X815781";

  system.stateVersion = "24.11";

  boot.hugepages1GB.number = 0;
  boot.hugepages2MB.number =
    let
      gb = 600;
    in
    gb * 1024 / 2;
}
