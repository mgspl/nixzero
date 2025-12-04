{pkgs, ...}:
with pkgs; let
  lockcommand = "${swaylock}/bin/swaylock --daemonize";
  unlockcommand = "pkill -SIGUSR1 swaylock";

  timeoutcommand = "${wlopm}/bin/wlopm --off eDP-1";
  resumecommand = "${wlopm}/bin/wlopm --on eDP-1";
  suspendcommand = "${systemd}/bin/systemctl suspend";
in {
  home.packages = [pkgs.wlopm];
  services.swayidle = {
    enable = true;
    systemdTarget = "niri-session.target";
    events = [
      {
        event = "before-sleep";
        command = lockcommand;
      }
      {
        event = "lock";
        command = lockcommand;
      }
      {
        event = "unlock";
        command = unlockcommand;
      }
      {
        event = "after-resume";
        command = resumecommand;
      }
    ];
    timeouts = [
      {
        timeout = 1800;
        command = lockcommand;
      }
      {
        timeout = 2700;
        command = timeoutcommand;
        resumeCommand = resumecommand;
      }
      {
        timeout = 5400;
        command = suspendcommand;
      }
    ];
  };
}
