{
  description = "VSCode flake for Insilica";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      with import nixpkgs { inherit system; };
      let
        extensions = (with vscode-extensions;
          [
            bbenoist.nix
            brettm12345.nixfmt-vscode
            codezombiech.gitignore
            editorconfig.editorconfig
            esbenp.prettier-vscode
            graphql.vscode-graphql
            kahole.magit
            ms-vscode-remote.remote-ssh
            ms-vsliveshare.vsliveshare
            rust-lang.rust-analyzer
            timonwong.shellcheck
          ] ++ (pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "calva";
              publisher = "betterthantomorrow";
              version = "2.0.381";
              sha256 = "sha256-7Tsqi1W4JdbUnJ8r+99LBFcvll73jqZzg1ohF8yevao=";
            }
            {
              name = "codescene-vscode";
              publisher = "CodeScene";
              version = "0.3.0";
              sha256 = "sha256-wY0EOxV9Q0VUqchqZUo1QCmIIPHY8PP6UhILSN4zFSc=";
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
              version = "0.305.0";
              sha256 = "sha256-srSRD/wgDbQo9P1uJk8YtcXPZO62keG5kRnp1TmHqOc=";
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
              version = "1.5.9";
              sha256 = "sha256-mSFaNMo8sLWZUBl0SAX/v2uoIBhArdxDOo0+XEHlKPY=";
            }];
        };
      in {
        packages = {
          inherit emacs intellij vscode;
          default = vscode;
        };
      });

}
