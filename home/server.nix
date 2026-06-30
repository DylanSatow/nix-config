# dylanserver — headless Ubuntu aarch64, standalone home-manager (user "ubuntu").
{...}: {
  imports = [
    ./common.nix
  ];

  home.username = "ubuntu";
  home.homeDirectory = "/home/ubuntu";

  programs.fish.loginShellInit = ''
    fish_add_path /home/ubuntu/.npm-global/bin
  '';
}
