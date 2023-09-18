{

  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        python = pkgs.python3.withPackages (ps: with ps; [ markdown pelican ]);
        website = pkgs.stdenv.mkDerivation {
          name = "website";
          src = ./.;
          nativeBuildInputs = [ python ];
          buildFlags = [ "publish" ];
          installPhase = "cp -r output $out";
        };
      in {
        packages.default = website;
        devShells.default = pkgs.mkShell { packages = [ python ]; };
      });

}
