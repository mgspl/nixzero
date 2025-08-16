{lib, ...}: {
  services.swaync = {
    enable = true;
    settings = {
      "$schema" = "/etc/xdg/swaync/configSchema.json";
      positionX = "right";
      positionY = "top";
      cssPriority = "user";
      layer = "overlay";
      layer-shell = "true";
      control-center-layer = "top";
      control-center-margin-top = 2;
      control-center-margin-bottom = 2;
      control-center-margin-right = 1;
      control-center-margin-left = 0;
      notification-icon-size = 64;
      notification-body-image-height = 128;
      notification-body-image-width = 200;
      timeout = 5;
      timeout-low = 3;
      timeout-critical = 0;
      fit-to-screen = false;
      control-center-width = 400;
      control-center-height = 730;
      notification-window-width = 375;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = true;
      hide-on-action = true;
      script-fail-notify = true;
      widgets = ["dnd" "buttons-grid" "mpris" "volume" "title" "notifications"];
      widget-config = {
        title = {
          text = "Notificações";
          clear-all-button = true;
          button-text = " ";
        };
        volume = {
          label = " ";
          expand-button-label = "";
          collapse-button-label = "";
          show-per-app = true;
          show-per-app-icon = true;
          show-per-app-label = true;
        };
        dnd = {text = " Não pertube";};
        mpris = {
          image-size = 50;
          image-radius = 0;
        };
        label = {
          text = "Notificações";
          max-lines = 1;
        };
        buttons-grid = {
          actions = [
            {
              label = "";
              command = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
              type = "toggle";
            }
            {
              label = "";
              command = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
              type = "toggle";
            }
            {
              label = "󰤨";
              command = "nm-connection-editor";
            }
            {
              label = "󰂯";
              command = "blueman-manager";
            }
            {
              label = "";
              command = "shutdown now";
            }
            {
              label = "󰤄";
              command = "loginctl suspend";
            }
            {
              label = "";
              command = "swaylock";
            }
            {
              label = "";
              command = "wlogout";
            }
          ];
        };
      };
      scripts = {
        example-script = {
          exec = "echo 'Do something...'";
          urgency = "Normal";
        };
      };
      notification-visibility = {
        spotify = {
          state = "enabled";
          urgency = "Low";
          app-name = "Spotify";
        };
        youtube-music = {
          state = "enabled";
          urgency = "Low";
          app-name = "com.github.th_ch.youtube_music";
        };
      };
    };
    style = ''
           /* Colors */
      @define-color background 	    #1e1e2e;
      @define-color background-alt 	    #181825;
      @define-color background-alt-darker #11111b;
      @define-color accent-normal    	    #89b4fa;
      @define-color accent-error     	    #f38ba8;
      @define-color bordercolor           #89b4fa;
      @define-color fontcolor 	    #cdd6f4;
      @define-color fontaltcolor 	    #bac2de;


      /* Config */

      * {
          font-family: "JetbrainsMono NFP SemiBold";
          font-style: italic;
      }

      /* Notification */

      .notification {
          background: @background;
          color: @fontcolor;
          border: 3px solid @bordercolor;
          border-radius: 10px;
          padding:10px;
      }

      .body {
        color: @fontcolor;
      }

      .summary {
        font-size: 16px;
        font-weight: 700;
        background: transparent;
        color: @accent-normal;
        text-shadow: none;
      }

      .time {
        font-size: 16px;
        font-weight: 700;
        background: transparent;
        color: @fontcolor;
        text-shadow: none;
        margin-right: 18px;
      }

      .close-button {
        background-color: @accent-error;
        color: @fontaltcolor;
        margin-top: 5px;
        margin-right: 5px;
        border-radius: 6px;
      }

      .notification-default-action:hover,
      .notification-action:hover {
          color: @fontcolor;
          background: transparent;
      }

      .notification.critical progress {
        background-color: @accent-error;
      }

      .notification.low progress,
      .notification.normal progress {
        background-color: @accent-normal;
      }

      /* Control Center */

      .control-center {
          background-color: @background;
          color: @fontcolor;
          border: 3px solid @bordercolor;
          padding: 10px;
      }

      /* Notifications expanded-group */

      .notification-group {
        background-color: transparent;
        margin: 2px 8px 2px 8px;
        font-size: 14px;

      }

      .notification-group-icon {
        color: @fontcolor;
      }

      .notification-group-headers {
        color: @fontcolor;
      }

      .notification-group-collapse-button,
      .notification-group-close-all-button {
        background: @accent-normal;
        color: @fontaltcolor;
        margin: 4px;
        border-radius: 6px;
        padding: 4px;
      }

      .notification-group-collapse-button:hover,
      .notification-group-close-all-button:hover {
        background: @accent-error;
        color: @fontaltcolor;
      }


      /* widget title */
      .widget-title {
        color: @fontcolor;
      }
      .widget-title>button {
        font-size: 1rem;
        color: @fontcolor;
        background: @background-alt-darker;
        box-shadow: none;
      }

      .widget-title>button:hover {
        background: @accent-error;
        color: @fontaltcolor;
      }

      /* widget button grid */
      button {
          border: 0px;
          min-width: 35px;
          background: @background-alt;
      }

      .widget-buttons-grid {
        font-size: x-large;
        background: @background-alt-darker;
      }

      .widget-buttons-grid > flowbox > flowboxchild > button {
          color: @fontcolor;
          margin: 8px;
          padding: 10px;
      }

      .widget-buttons-grid>flowbox>flowboxchild>button:hover {
        background: alpha(@fontcolor, 0.55);
      }

      .widget-buttons-grid > flowbox > flowboxchild > button.toggle:checked {
        background: @accent-normal;
      }

      .widget-buttons-grid > flowbox > flowboxchild > button.toggle:checked label {
          color: @fontaltcolor;
      }




      /* dnd widget */
      .widget-dnd {
        background: transparent;
        border: 1px solid transparent;
        font-size: large;
        color: @fontcolor;
      }

      .widget-dnd>label {
        color: @fontcolor;
      }

      .widget-dnd>switch {
        background: @background-alt;
        color: @fontcolor;
        border-radius: 6px;
      }

      .widget-dnd>switch:checked {
        background: @accent-error;
        border: 1px solid @accent-error;
      }


      /* volume & backlight widget */

      .widget-volume {
        background: @background-alt-darker;
        color: @fontcolor;
        font-size: x-large;
      }


      .widget-backlight {
        background: @background-alt-darker;
        color: @fontcolor;
        font-size: x-large;
      }

      /* music player widget */
      .widget-mpris {
        background: transparent;
        margin: 4px;
      }

      .widget-mpris button {
        background-color: transparent;
        border-radius: 6px;
      }

      .widget-mpris button:hover {
        background-color: @accent-normal;
        color: @fontaltcolor;
      }


      /* sliders in backlight and volume */

      trough slider {
          background: @fontcolor;
      }

      trough slider:hover {
          background: @accent-normal;
      }


      trough highlight {
        background: @accent-normal;
    '';
  };

  #systemd.user.services.swaync.User.After = lib.mkForce "graphical-session.target";
}
