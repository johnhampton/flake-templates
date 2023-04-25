{
  description = "A helm chart";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    hchart.url = "github:topagentnetwork/hchart";
  };

  outputs = { self, nixpkgs, flake-utils, hchart }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.kubernetes-helm-wrapped
          hchart.packages.${system}.default
        ];
      };
    });
}
