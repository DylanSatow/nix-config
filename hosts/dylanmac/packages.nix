{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        # Academic/Publishing
        texliveFull

        # Node ecosystem (macOS preference)
        poetry
        pnpm

        markdown-oxide
    ];
}
