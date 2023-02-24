{
  description = "VSCode flake for Insilica";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      with import nixpkgs { inherit system; };
      let
        extensions = (with vscode-extensions; [
          bbenoist.nix
          betterthantomorrow.calva
          brettm12345.nixfmt-vscode
          codezombiech.gitignore
          editorconfig.editorconfig
          graphql.vscode-graphql
          kahole.magit
          ms-vscode-remote.remote-ssh
        ]);
        vscode = pkgs.vscode-with-extensions.override {
          vscodeExtensions = extensions;
        };
        emacs = pkgs.vscode-with-extensions.override {
          vscodeExtensions = extensions
            ++ vscode-utils.extensionsFromVscodeMarketplace [{
              name = "emacs-mcx";
              publisher = "tuttieee";
              version = "0.47.0";
              sha256 = "sha256-dGty5+1+JEtJgl/DiyqEB/wuf3K8tCj1qWKua6ongIs=";
            }];
        };
        intellij = pkgs.vscode-with-extensions.override {
          vscodeExtensions = extensions
            ++ vscode-utils.extensionsFromVscodeMarketplace [{
              name = "intellij-idea-keybindings";
              publisher = "k--kato";
              version = "1.5.5";
              sha256 = "sha256-ltzkeJ5nlfqWiGeXelRKMv5M/xBor1gSdRUwyw/RrtA=";
            }];
        };
      in {
        packages = {
          inherit emacs intelli vscode;
          default = vscode;
        };
      });

}
