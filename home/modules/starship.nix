# Starship prompt — cross-shell, used by both fish and zsh (integration is on by
# default in home-manager for each enabled shell). Catppuccin Mocha colors come
# from the global catppuccin.enable in theme.nix; here we only set the layout:
# a compact single line ending in a `›` chevron.
{...}: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };

      # Restyle the default cmd_duration segment like his: bare yellow duration,
      # no "took" prefix. (It's already part of starship's default format.)
      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };
    };
  };
}
