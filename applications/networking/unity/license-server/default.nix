{ stdenv, lib, pkgs }:

with pkgs; 
stdenv.mkDerivation rec {
  name    = "Unity.Licensing.Server.linux-x64-v${version}";
  version = "1.8.0";
  dontStrip = true;

  src = fetchGit {
    url  = "git@github.com:PlayOneMoreGame/unity-license-server.git";
    name = "src";
    ref  = "master";
  };

  nativeBuildInputs = [
    unzip
  ];

  unpackPhase = ''
    unzip $src/${name}.zip
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r ./${name}/* $out/bin
  '';

  meta = with lib; {
    homepage    = https://unity.com;
    description = "${name}";
    platforms   = platforms.linux;
  };
}
