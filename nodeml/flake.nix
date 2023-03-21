{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    devenv.url = "github:cachix/devenv";
  };

  outputs = { self, nixpkgs, devenv, ... } @ inputs:
    let
      nodeVersion = "nodejs-14_x";

      systems = [ "x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = f: builtins.listToAttrs (map (name: { inherit name; value = f name; }) systems);

      overlay = final: prev: { nodejs = prev."${nodeVersion}"; };

      pkgs_x86-64 = import nixpkgs { system = "x86_64-darwin"; overlays = [ overlay ]; };
    in
    {
      devShells = forAllSystems
        (system:
          let
            pkgs = import nixpkgs {
              inherit system;

              # Make sure we are using node 12
              overlays = [ overlay ];
            };

            ocamlPackages =
              if system == "aarch64-darwin"
              then pkgs_x86-64.ocaml-ng.ocamlPackages_4_06
              else pkgs.ocaml-ng.ocamlPackages_4_06;
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  # https://devenv.sh/reference/options/
                  packages = [
                    ocamlPackages.ocaml-lsp

                    # pkgs.nodePackages.ocaml-language-server
                    pkgs.nodePackages.eslint_d
                    pkgs.nodePackages.yarn
                    pkgs.nodePackages.typescript-language-server
                  ];
                  languages.javascript.enable = true;
                  languages.javascript.package = pkgs.nodejs;
                }
              ];
            };
          });
    };
}
