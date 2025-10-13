{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        # Core system utils 
        zip
        unzip
        gh
    ];
}
