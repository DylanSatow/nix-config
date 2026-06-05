# dylanserver — headless Ubuntu aarch64, standalone home-manager (user "ubuntu").
{...}: {
  imports = [
    ./common.nix
  ];

  home.username = "ubuntu";
  home.homeDirectory = "/home/ubuntu";

  programs.zsh.initContent = ''
    export PATH="/home/ubuntu/.npm-global/bin:$PATH"
  '';
}
