{ stdenv, lib, pkgs }:

with pkgs; 
stdenv.mkDerivation rec {
  name = "unity-license-server-${version}";
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
    unzip $src/Unity.Licensing.Server.linux-x64-v1.8.0.zip
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r ./Unity.Licensing.Server.linux-x64-v1.8.0/* $out/bin
  '';

  meta = with lib; {
    homepage = https://unity.com;
    description = "Unity Linux License Server";
    platforms = platforms.linux;
    maintainers = with maintainers; [ makefu ];
  };
}
