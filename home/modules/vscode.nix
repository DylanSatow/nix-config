# VS Code is installed by hand (no longer a nix package). Home-manager only links
# settings.json into place. macOS does NOT follow XDG, so this lives under
# ~/Library/Application Support/, not ~/.config. Imported only by the mac config.
#
# Extensions are now managed manually inside VS Code. For reference, the set this
# config previously installed via nix:
#   ms-vscode-remote.remote-containers, remote-ssh, vscode-remote-extensionpack
#   vscodevim.vim
#   james-yu.latex-workshop
#   pkief.material-icon-theme, pkief.material-product-icons
#   ms-python.python, ms-python.pylint, ms-python.black-formatter
#   bbenoist.nix, golang.go
#   ms-vscode.cpptools, cpptools-extension-pack, cmake-tools
{lib, ...}: let
  userSettings = {
    "workbench.sideBar.location" = "right";

    "terminal.integrated.stickyScroll.enabled" = false;

    "vim.useSystemClipboard" = true;
    "vim.hlsearch" = true;

    "editor.fontFamily" = "JetBrainsMono Nerd Font";
    "editor.lineNumbers" = "on";
    "editor.minimap.enabled" = true;

    "python.defaultInterpreterPath" = "/usr/bin/python3";
    "python.formatting.provider" = "black";
    "go.formatTool" = "goimports";
    "go.useLanguageServer" = true;

    "latex-workshop.latex.autoClean.run" = "onBuilt";
    "latex-workshop.latex.autoBuild.run" = "onSave";
  };
in {
  home.file."Library/Application Support/Code/User/settings.json".text =
    (lib.generators.toJSON {} userSettings) + "\n";
}
