## nix-vscode

VSCode built with extensions for Clojure, Rust, and general development. Supports Linux and macOS.

## Usage

[Install Nix](https://github.com/DeterminateSystems/nix-installer):
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

- With default keybindings:
    - `NIXPKGS_ALLOW_UNFREE=1 nix run github:insilica/nix-vscode --impure`
- With emacs keybindings:
    - `NIXPKGS_ALLOW_UNFREE=1 nix run github:insilica/nix-vscode#emacs --impure`
- With IntelliJ keybindings:
    - `NIXPKGS_ALLOW_UNFREE=1 nix run github:insilica/nix-vscode#intellij --impure`
