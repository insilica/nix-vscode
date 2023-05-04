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
        extensions = (with vscode-extensions;
          [
            bbenoist.nix
            betterthantomorrow.calva
            brettm12345.nixfmt-vscode
            codezombiech.gitignore
            editorconfig.editorconfig
            graphql.vscode-graphql
            kahole.magit
            ms-vscode-remote.remote-ssh
            ms-vsliveshare.vsliveshare
            rust-lang.rust-analyzer
            timonwong.shellcheck
          ] ++ (pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "codescene-vscode";
              publisher = "CodeScene";
              version = "0.2.1";
              sha256 = "sha256-EslE2ee9EoPa3bOGNAxtTdj5QRs9JuaF/efYu9rHOCw=";
            }
            {
              name = "joyride";
              publisher = "betterthantomorrow";
              version = "0.0.33";
              sha256 = "sha256-bHQKCdq1nQI1GFcX4AgSULDH5kOk5DARnWZoUga8u30=";
            }
            {
              name = "remote-containers";
              publisher = "ms-vscode-remote";
              version = "0.293.0";
              sha256 = "sha256-O0hM+GKZ46moihBlPvfNuqfLazR5WVqEaE6XiEnaNN0=";
            }
            {
              name = "vscode-direnv";
              publisher = "cab404";
              version = "1.0.0";
              sha256 = "0xikkhbzb5cd0a96smj5mr1sz5zxrmryhw56m0139sbg7zwwfwps";
            }
          ]));
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
          inherit emacs intellij vscode;
          default = vscode;
        };
      });

}
