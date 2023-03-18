{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    devenv.url = "github:cachix/devenv";
  };

  outputs = { self, nixpkgs, devenv, ... } @ inputs:
    let
      systems = [ "x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = f: builtins.listToAttrs (map (name: { inherit name; value = f name; }) systems);
    in
    {
      devShells = forAllSystems
        (system:
          let
            pkgs = import nixpkgs {
              inherit system;

              # Make sure we are using node 18
              overlays = [ (final: prev: { nodejs = prev.nodejs-18_x; }) ];
            };
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  # https://devenv.sh/reference/options/
                  packages = [
                    pkgs.nodePackages.eslint_d
                    pkgs.nodePackages.pnpm
                    pkgs.nodePackages.typescript-language-server
                  ];
                  languages.javascript.enable = true;
                  languages.javascript.package = pkgs.nodejs;
                  languages.typescript.enable = true;
                }
              ];
            };
          });
    };
}
