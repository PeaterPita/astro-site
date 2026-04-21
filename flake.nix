{
  description = "Nix-Flake based Web Dev Shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };

    in
    {
      packages.${system}.default = pkgs.buildNpmPackage {
        pname = "astro-site";
        version = "0.1.0";

        src = ./.;
        npmDepsHash = "sha256-CL3rvvwdgq8HO//CXnbXG2kUy6oOJeF73t1xyutSlFQ=";

        buildPhase = ''
          npx astro build
        '';

        installPhase = ''
          cp -r dist $out
        '';
      };
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          nodejs_24
        ];

      };
    };
}
