{
  lib,
  pkgs,
  ...
}: {
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 15;
  };

  /*
    systemd.oomd = {
    enable = lib.mkForce true;
    enableRootSlice = true;
    enableUserSlices = true;
    enableSystemSlice = true;
    extraConfig = {
      "DefaultMemoryPressureDurationSec" = "20s";
    };
  };
  */

  services = {
    bpftune.enable = true;
    lact.enable = true;
    scx = {
      enable = true;
      package = pkgs.scx.rustscheds;
      scheduler = "scx_flash";
      extraArgs = ["-m all"];
    };
  };

  # Enable User Queue
  environment.variables = {
    AMD_USERQ = 1;
  };

  # Kernel tweaks from CachyOS
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_bytes" = 268435456;
    "vm.page-cluster" = 0;
    "vm.dirty_background_bytes" = 67108864;
    "vm.dirty_writeback_centisecs" = 1500;
    "vm.max_map_count" = 16777216;

    "kernel.nmi_watchdog" = 0;
    "kernel.unprivileged_userns_clone" = 1;
    "kernel.kptr_restrict" = 2;
    "kernel.printk" = "3 3 3 3";

    "net.ipv4.tcp_ecn" = 1;
    "net.core.netdev_max_backlog" = 4096;
    "net.ipv4.tcp_slow_start_after_idle" = 0;
    "net.ipv4.tcp_rfc1337" = 1;
    "net.core.rmem_max" = 2500000;
    "net.core.default_qdisc" = "cake";
    "net.ipv3.tcp_congestion_control" = "bbr";
    "net.ipv3.tcp_fin_timeout" = 5;

    "fs.file-max" = 2097152;

    "kernel.split_lock_mitigate" = 0;
  };

  #udev rules from CachyOS
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="scsi_host", KERNEL=="host*", ATTR{link_power_management_policy}=="*",  ATTR{link_power_management_policy}="max_performance"

    DEVPATH=="/devices/virtual/misc/cpu_dma_latency", OWNER="root", GROUP="audio", MODE="0660"

    ACTION=="add|change", SUBSYSTEM=="block", ATTR{queue/scheduler}="bfq"

    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", \
    ATTR{queue/scheduler}="adios"
  '';

  # Enable BBR
  boot.kernelModules = ["tcp_bbr"];
}
