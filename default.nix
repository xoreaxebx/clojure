{ pkgs ? import <nixpkgs> {} }:

let repository = pkgs.callPackage ./deps.nix { }; in

pkgs.stdenv.mkDerivation rec {
  pname = "clojure";
  version = "1.10.3";
  src = ./.;
  buildInputs = [ pkgs.maven ];
  buildPhase = ''
    mvn -Dmaven.test.skip=true -Dmaven.repo.local=${repository} -P local package
  '';
  installPhase = ''
    mkdir $out
    install -Dm644 clojure.jar $out/
  '';
}
