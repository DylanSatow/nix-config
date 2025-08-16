{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.spotify
    pkgs.obsidian

    # Core system utils 
    pkgs.zip
    pkgs.unzip

    # Tutorials 
    pkgs.bootdev-cli
  ];
}
