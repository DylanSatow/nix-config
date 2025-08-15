{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.spotify
    pkgs.obsidian
  ];
}