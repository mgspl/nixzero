{
  inputs,
  pkgs,
  ...
}: {
  programs.dankMaterialShell = {
    enable = true;
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
      withX11 = false;
      withCrashReporter = false;
    };

    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableClipboard = true; # Clipboard history manager
    enableVPN = false; # VPN management widget
    enableBrightnessControl = false; # Backlight/brightness controls
    enableColorPicker = false; # Color picker tool
    enableDynamicTheming = false; # Wallpaper-based theming (matugen)
    enableAudioWavelength = false; # Audio visualizer (cava)
    enableCalendarEvents = false; # Calendar integration (khal)
    enableSystemSound = true; # System sound effects

    niri = {
      enableKeybinds = false; # Automatic keybinding configuration
      enableSpawn = true; # Auto-start DMS with niri
    };
  };
}
