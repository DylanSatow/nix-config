{ config, pkgs, ... }:

{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = 300;
          "on-timeout" = "brightnessctl -s set 10";
          "on-resume" = "brightnessctl -r";
        }
        {
          timeout = 600;
          "on-timeout" = "hyprlock";
        }
        {
          timeout = 1800;
          "on-timeout" = "hyprctl dispatch dpms off";
          "on-resume" = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}