{
  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      python = pkgs.python3.withPackages (ps:
        with ps; [
          markdown
          (pelican.overrideAttrs (_: _: {patches = [./pelican.patch];}))
          (
            buildPythonPackage rec {
              pname = "pelican-sitemap";
              version = "1.1.0";
              src = pkgs.fetchFromGitHub {
                owner = "pelican-plugins";
                repo = "sitemap";
                rev = version;
                sha256 = "sha256-GEOLM4wc25VLRZ4qpOENTV6YGfYPHeu95gGdBauJswA=";
              };
              format = "pyproject";
              propagatedBuildInputs = [poetry-core];
            }
          )
        ]);
      website = pkgs.stdenv.mkDerivation {
        name = "website";
        src = ./.;
        nativeBuildInputs = [pkgs.libfaketime python];
        buildPhase = "faketime @${builtins.toString self.lastModified} make publish";
        installPhase = "cp -r output $out";
      };
    in {
      packages.default = website;
      devShells.default = pkgs.mkShell {packages = [python];};
    });
}
