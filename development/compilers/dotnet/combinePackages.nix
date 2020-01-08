{ cli
, withRuntimes ? []
, withSdks ? []
}:
  assert (builtins.length withRuntimes) != 0 || (builtins.length withSdks) != 0;
  { stdenv }:
  stdenv.mkDerivation rec {
    name = "dotnet-core-combined";

    runtimes = withRuntimes;
    sdks = withSdks;
    inherit cli;

    builder = ./combine-packages-builder.sh;

    meta = with stdenv.lib; {
      homepage = https://dotnet.github.io/;
      description = ".NET Core combined package";
      platforms = [ "x86_64-linux" "x86_64-darwin" ];
      license = licenses.mit;
    };
  }
