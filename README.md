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

If your Nix configuration does not support those commands, this longer command should work: `NIXPKGS_ALLOW_UNFREE=1 nix --extra-experimental-features nix-command --extra-experimental-features flakes run github:insilica/nix-vscode --impure`

## Customizing

Clone or fork the repo, and add your desired extensions to flake.nix.
Extension definitions look like this:
```nix
{
    name = "calva";
    publisher = "betterthantomorrow";
    version = "2.0.381";
    sha256 = "sha256-7Tsqi1W4JdbUnJ8r+99LBFcvll73jqZzg1ohF8yevao=";
}
```

When adding or changing an extension, set the sha256 line to `sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";` and run `bin/build`

You will get an error message like this:
```
error: hash mismatch in fixed-output derivation '/nix/store/fa50shp9j4ccxcybqwjfpsjcxhim45k9-betterthantomorrow-calva.zip.drv':
         specified: sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
            got:    sha256-7Tsqi1W4JdbUnJ8r+99LBFcvll73jqZzg1ohF8yevao=
```

Copy the "got" value into the sha256 entry, and run `bin/build` again. If the build succeeds, you are done!

Note that some extensions rely on downloading binary code from a website and executing it.
Many of these extensions won't work because the VSCode directories this creates are read-only.
One work-around that I've used is to install VSCode from another source and run it to install the problem extension.
After verifying that the extension is working, I close that VSCode and run nix-vscode.
Usually, the extension works well.

To run your custom build, use `bin/run` from the repo directory. Use `bin/run .#emacs` or `bin/run .#intellij` if you want those keybindings. You can also push your repo to GitHub and run it with `NIXPKGS_ALLOW_UNFREE=1 nix run github:username/repo-name --impure`

### Updating VSCode

This project typically uses a stable channel which may have a slightly older version of VSCode. Newer versions of VSCode are available in the nixpkgs-unstable channel.
Change the `nixpkgs.url` line at the start of flake.nix to:
```nix
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
```
and run `bin/build`
