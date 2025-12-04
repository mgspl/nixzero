{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  services.swww.enable = true;

  programs.niri.settings = {
    spawn-at-startup = [
      {sh = "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP";}
      {command = ["swaybg" "-i" "/home/miguel/nixzero/assets/blurred.jpg"];}
      {command = ["gsr-ui"];}
      {command = ["openrgb" "-c" "89b4fa"];}
      {command = ["swww" "img" "~/nixzero/assets/wallpaper.png"];}
    ];
    # Input Settings
    input = {
      focus-follows-mouse.enable = true;

      mouse = {
        accel-profile = "adaptive";
        natural-scroll = true;
      };

      keyboard = {
        #repeat-delay = 500;
        #repeat-rate = 25;
        repeat-delay = 300;
        repeat-rate = 30;
        xkb.layout = "br";
      };
    };

    # Cursor Theme
    cursor.theme = "Bibata-Modern-Ice";

    layout = {
      preset-column-widths = [
        {proportion = 0.5;}
        {proportion = 0.5;}
      ];
      default-column-width = {proportion = 0.5;};
      gaps = 3;
      # Border Config
      border = {
        enable = true;
        width = 2;
        active.color = "#89b4fa";
        inactive.color = "#1e1e2e";
        urgent.color = "#f38ba8";
      };

      focus-ring.enable = false;

      shadow = {
        enable = true;
        color = "#89b4fa08";
      };
    };

    environment = {
      DISPLAY = ":0";
    };

    overview = {
      workspace-shadow = {
        enable = true;
        color = "#89b4fa";
      };
    };

    prefer-no-csd = true;
    hotkey-overlay.skip-at-startup = true;
    screenshot-path = "~/Imagens/%Y-%m-%dT%H-%M-%S.png";

    xwayland-satellite = {
      enable = true;
      path = "${lib.getExe pkgs.xwayland-satellite-unstable}";
    };

    layer-rules = [
      {
        matches = [{namespace = "^swaync-notification-window$";}];
        block-out-from = "screen-capture";
      }
      {
        matches = [{namespace = "^wallpaper$";}];
        place-within-backdrop = true;
      }
    ];

    window-rules = [
      {
        matches = [
          {
            title = "^Picture-in-picture$";
          }
          {
            app-id = "^vivaldi-stable$";
            title = "^Picture-in-Picture$";
          }
          {
            app-id = "^firefox$";
            title = "^Picture-in-Picture$";
          }
        ];
        open-floating = true;
      }
      {
        matches = [
          {app-id = "^helium$";}
          {app-id = "^firefox$";}
        ];
        open-maximized = true;
      }
      {
        geometry-corner-radius.bottom-left = 8.0;
        geometry-corner-radius.bottom-right = 8.0;
        geometry-corner-radius.top-left = 8.0;
        geometry-corner-radius.top-right = 8.0;
        clip-to-geometry = true;
      }

      {
        matches = [{title = "^gsr notify$";}];
        block-out-from = "screen-capture";
      }
    ];

    binds = with config.lib.niri.actions; let
      sh = spawn "sh" "-c";
    in
      lib.attrsets.mergeAttrsList [
        {
          "Mod+T".action = spawn "kitty";
          "Mod+O".action = toggle-overview;
          "Mod+Tab".action = toggle-overview;
          "Mod+R".action = sh "dms ipc spotlight toggle";
          "Mod+W".action = spawn "firefox";
          "Mod+E".action = spawn "nautilus";
          "Mod+C".action = sh "dms ipc clipboard toggle";
          "Mod+M".action = sh "dms ipc powermenu toggle";
          "Mod+P".action = sh "dms ipc processlist toggle";
          "Mod+N".action = sh "dms ipc call spotlight toggleQuery ':'";
          "Mod+ccedilla".action = sh "dms ipc lock lock";

          "Print".action.screenshot = [];
          "Ctrl+Print".action.screenshot-screen = [];
          "Alt+Print".action.screenshot-window = [];

          "Mod+Insert".action = set-dynamic-cast-window;
          "Mod+Shift+Insert".action = set-dynamic-cast-monitor;
          "Mod+Delete".action = clear-dynamic-cast-target;

          "XF86AudioRaiseVolume".action = sh "dms ipc audio increment 5";
          "XF86AudioLowerVolume".action = sh "dms ipc audio decrement 5";
          "XF86AudioMute".action = sh "dms ipc audio mute";

          #"Caps_Lock".action = sh "swayosd-client --caps-lock";

          "Mod+Q".action = close-window;

          "Mod+Space".action = center-column;

          "XF86AudioPlay".action = sh "playerctl play-pause";
          "XF86AudioNext".action = sh "playerctl next";
          "XF86AudioPrev".action = sh "playerctl previous";

          #"Mod+Tab".action = focus-window-down-or-column-right;
          #"Mod+Shift+Tab".action = focus-window-up-or-column-left;

          "Mod+WheelScrollDown".action = focus-column-right;
          "Mod+WheelScrollUp".action = focus-column-left;
          "Mod+Shift+WheelScrollDown".action = move-column-right;
          "Mod+Shift+WheelScrollUp".action = move-column-left;
        }
        {
          "Mod+Left".action = focus-column-left;
          "Mod+Down".action = focus-window-down;
          "Mod+Up".action = focus-window-up;
          "Mod+Right".action = focus-column-right;
          "Mod+H".action = focus-column-left;
          "Mod+J".action = focus-window-down;
          "Mod+K".action = focus-window-up;
          "Mod+L".action = focus-column-right;
          "Mod+Shift+Left".action = move-column-left;
          "Mod+Shift+Down".action = move-window-down;
          "Mod+Shift+Up".action = move-window-up;
          "Mod+Shift+Right".action = move-column-right;
          "Mod+Shift+H".action = move-column-left;
          "Mod+Shift+J".action = move-window-down;
          "Mod+Shift+K".action = move-window-up;
          "Mod+Shift+L".action = move-column-right;
        }
        {
          "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
          "Mod+V".action = toggle-window-floating;
        }
        {
          "Mod+U".action = focus-workspace-down;
          "Mod+I".action = focus-workspace-up;
          "Mod+Shift+U".action = move-column-to-workspace-down;
          "Mod+Shift+I".action = move-column-to-workspace-up;
          "Mod+Ctrl+U".action = move-workspace-down;
          "Mod+Ctrl+I".action = move-workspace-up;
        }
        {
          "Mod+1".action.focus-workspace = 1;
          "Mod+2".action.focus-workspace = 2;
          "Mod+3".action.focus-workspace = 3;
          "Mod+4".action.focus-workspace = 4;
          "Mod+5".action.focus-workspace = 5;
          "Mod+6".action.focus-workspace = 6;
          "Mod+7".action.focus-workspace = 7;
          "Mod+8".action.focus-workspace = 8;
          "Mod+9".action.focus-workspace = 9;
          "Mod+Shift+1".action.move-window-to-workspace = 1;
          "Mod+Shift+2".action.move-window-to-workspace = 2;
          "Mod+Shift+3".action.move-window-to-workspace = 3;
          "Mod+Shift+4".action.move-window-to-workspace = 4;
          "Mod+Shift+5".action.move-window-to-workspace = 5;
          "Mod+Shift+6".action.move-window-to-workspace = 6;
          "Mod+Shift+7".action.move-window-to-workspace = 7;
          "Mod+Shift+8".action.move-window-to-workspace = 8;
          "Mod+Shift+9".action.move-window-to-workspace = 9;
        }
        {
          "Mod+Comma".action = consume-window-into-column;

          "Mod+Period".action = expel-window-from-column;
          "Mod+BracketLeft".action = consume-or-expel-window-left;
          "Mod+BracketRight".action = consume-or-expel-window-right;
          "Mod+D".action = switch-preset-column-width;
          "Mod+Shift+D".action = switch-preset-window-height;
          "Mod+Ctrl+D".action = reset-window-height;
          "Mod+F".action = maximize-window-to-edges;
          "Mod+Shift+F".action = fullscreen-window;
          "Mod+Ctrl+F".action = toggle-windowed-fullscreen;

          "Mod+Minus".action = set-column-width "-10%";
          "Mod+Equal".action = set-column-width "+10%";
          "Mod+Shift+Minus".action = set-window-height "-10%";
          "Mod+Shift+Equal".action = set-window-height "+10%";

          "Mod+Shift+Escape".action = toggle-keyboard-shortcuts-inhibit;
          "Mod+Shift+E".action = quit;
          "Mod+Shift+P".action = power-off-monitors;
        }
      ];
  };
}
