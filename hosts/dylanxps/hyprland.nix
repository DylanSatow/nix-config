{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    waybar
    rofi-wayland
    swww
    grim
    slurp
    wl-clipboard
    brightnessctl
    playerctl
    pavucontrol
    networkmanagerapplet
    mako
    hyprpicker
    hypridle
    hyprlock
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  security.pam.services.hyprlock = {};

  programs.hyprland.enable = true;
  
  security.polkit.enable = true;
  
  services.gnome.gnome-keyring.enable = true;
  
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}