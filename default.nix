{
  system ? builtins.currentSystem,
  pkgs ? import (builtins.fetchTarball {
    url = "https://github.com/nixos/nixpkgs/archive/56c0d09b76608a7fa28127a37d81d9003e46acf6.tar.gz";
  }) { inherit system; },
  papermod ? pkgs.fetchFromGitHub {
    owner = "adityatelange";
    repo = "hugo-papermod";
    rev = "master";
    hash = "sha256-Dv/QnYYG5KTQro95kzwgQeOS0nO2HyfBoSou5AsCFAI=";
  },
}:
pkgs.stdenv.mkDerivation {
  name = "website";
  src = ./.;
  postPatch = "mkdir themes && cp -r ${papermod} themes/papermod";
  nativeBuildInputs = [ pkgs.hugo ];
  buildPhase = "hugo";
  installPhase = "cp -r public $out";
}
