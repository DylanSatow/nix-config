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

    services.xserver.enable = true; # allow window managers 

    # Enable gnome 
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    environment.gnome.excludePackages = (with pkgs; [
        gnome-photos
        gnome-tour
        gnome-music
        gedit # text editor
        epiphany # web browser
        geary # email reader
        gnome-characters
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
        yelp # Help view
        gnome-contacts
        gnome-initial-setup

    ]);

    programs.dconf.enable = true;
    environment.systemPackages = with pkgs; [
        gnome-tweaks
    ];

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

    programs.zsh.enable = true;
    users.users.dylan = {
        isNormalUser = true;
        description = "dylansatow";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.zsh;
    };

    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = "25.05";

    security.polkit.enable = true;
    
    services.gnome.gnome-keyring.enable = true;
    
    services.blueman.enable = true;

    hardware.bluetooth = {
        enable = true;
        settings = {
            General = {
                Enable = "Source,Sink,Media,Socket";
            };
        };
    };
}
