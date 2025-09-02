{ config, pkgs, ... }: {
    home.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
    ] ++ (if pkgs.stdenv.isLinux then [ valgrind ] else []);
}
