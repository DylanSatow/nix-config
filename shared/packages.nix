{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        # AI tools
        unstable.claude-code
        unstable.gemini-cli
    ];
}
