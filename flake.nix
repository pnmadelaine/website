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
      in {
        packages.default = pkgs.writeTextDir "index.html" ''
          Hello world!
          This is the personal website of Paul-Nicolas Madelaine.
        '';
        devShells.default = pkgs.mkShell { packages = [ python ]; };
      });

}
