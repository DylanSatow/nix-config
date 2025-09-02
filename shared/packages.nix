{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        gh

        # AI tools
        unstable.claude-code
        unstable.gemini-cli
    ];
}
