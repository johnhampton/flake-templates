{
  inputs = {
    devenv.url = "github:cachix/devenv";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  };

  outputs = { self, devenv, flake-utils, nixpkgs }@inputs: flake-utils.lib.eachDefaultSystem (system:
    let
      ghcVersion = "ghc810";
      pkgs = nixpkgs.legacyPackages.${system};
      haskellPackages = pkgs.haskell.packages."${ghcVersion}";
    in
    {
      devShells.default = devenv.lib.mkShell ({
        inherit inputs pkgs;
        modules = [{
          packages = [
            haskellPackages.implicit-hie
          ];

          languages.haskell.enable = true;
          languages.haskell.package = pkgs.haskell.compiler."${ghcVersion}";
          languages.haskell.languageServer = haskellPackages.haskell-language-server;
        }];
      });
    });
}
