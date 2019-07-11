{ stdenv,
  buildPythonPackage,
  fetchPypi,
}:

buildPythonPackage rec {
  pname = "argparse";
  version = "1.4.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1r6nznp64j68ih1k537wms7h57nvppq0szmwsaf99n71bfjqkc32";
  };
}
