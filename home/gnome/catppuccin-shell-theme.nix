{pkgs}:
pkgs.stdenvNoCC.mkDerivation {
  pname = "catppuccin-shell-korpsvart";
  version = "unstable-2026-04-14";

  src = pkgs.fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Catppuccin-GTK-Theme";
    rev = "f25d8cf688d8f224f0ce396689ffcf5767eb647e";
    hash = "sha256-W+NGyPnOEKoicJPwnftq26iP7jya1ZKq38lMjx/k9ss=";
  };

  nativeBuildInputs = [pkgs.sassc];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    patchShebangs themes/install.sh
    mkdir -p $out/share/themes
    bash themes/install.sh \
      -n Catppuccin \
      -t lavender \
      -c dark \
      --tweaks macos \
      -d "$out/share/themes"

    runHook postInstall
  '';
}
