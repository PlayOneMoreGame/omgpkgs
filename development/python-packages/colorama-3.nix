{ stdenv,
  buildPythonPackage,
  fetchPypi,
}:

buildPythonPackage rec {
  pname = "colorama";
  version = "0.3.9";

  src = fetchPypi {
    inherit pname version;
    sha256 = "48eb22f4f8461b1df5734a074b57042430fb06e1d61bd1e11b078c0fe6d7a1f1";
  };
}
