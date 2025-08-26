{ config, pkgs, ... }:

{
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Fix 144hz monitor support in Hyprland
    boot.kernelParams = [ "nvidia-modeset.hdmi_deepcolor=0" ];


    networking.hostName = "dylanpc";
    networking.networkmanager.enable = true;

    time.timeZone = "America/New_York";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    programs.hyprland = {
        xwayland.enable = true;
    };

    xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [ 
            xdg-desktop-portal-hyprland 
            xdg-desktop-portal-gtk
        ];
    };

    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

    services.printing.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    users.users.dylan = {
        isNormalUser = true;
        description = "dylansatow";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.zsh;
    };

    programs.firefox.enable = true;
    programs.zsh.enable = true;

    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.stateVersion = "25.05";

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

    security.polkit.enable = true;
    
    services.gnome.gnome-keyring.enable = true;
    
    services.blueman.enable = true;

    hardware.bluetooth = {
        enable = true;
        config    = {
            General = {
                Enable = "Source,Sink,Media,Socket";
            };
        };
    };

    environment.etc."xdg/user-dirs.defaults".text = ''
        DOWNLOAD=Downloads
    '';
}
