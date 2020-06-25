{ pkgs ? import <nixpkgs> {} }:

with pkgs.idrisPackages;

build-idris-package rec {
  name = "vzipper";
  version = "0.1";

  idrisDeps = [ comonad ];

  extraBuildInputs = [];

  src = ./.;

  meta = {
    description = "Fixed length vector zipper in Idris";
  };
}
