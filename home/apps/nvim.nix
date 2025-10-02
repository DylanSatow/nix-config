{ pkgs, ... }: {
    programs.nvim = {
        enable = true;

    }
    xdg.configFile.nvim.source = ./nvim;
}