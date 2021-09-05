{ lib, stdenv, maven }:
stdenv.mkDerivation {
  name = "maven-repository";
  buildInputs = [ maven ];
  src = ./.;
  buildPhase = ''
    mvn -Dmaven.test.skip=true -Dmaven.repo.local=$out -P local package
  '';
  installPhase = ''
    find $out -type f \
      -name \*.lastUpdated -or \
      -name resolver-status.properties -or \
      -name _remote.repositories \
      -delete
  '';
  dontFixup = true;
  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = "1z64hzaq8il8n44hygvkb96sjdfl8qwa18axkzqcic6hxdw7lscl";
}
