{
  system ? builtins.currentSystem,
  sources ? import ./npins,
  pkgs ? import sources.nixpkgs { inherit system; },
  papermod ? sources.hugo-papermod,
}:
pkgs.stdenv.mkDerivation {
  name = "website";
  src = ./.;
  postPatch = "mkdir themes && cp -r ${papermod} themes/papermod";
  nativeBuildInputs = [ pkgs.hugo ];
  buildPhase = "hugo";
  installPhase = "cp -r public $out";
}
