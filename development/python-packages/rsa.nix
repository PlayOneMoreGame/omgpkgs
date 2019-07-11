{ stdenv,
  buildPythonPackage,
  fetchPypi,
  unittest2,
  pyasn1,
  mock,
  isPy3k,
  pythonOlder
}:

buildPythonPackage rec {
  pname = "rsa";
  version = "3.4.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "25df4e10c263fb88b5ace923dd84bf9aa7f5019687b5e55382ffcdb8bede9db5";
  };

  checkInputs = [ unittest2 mock ];
  propagatedBuildInputs = [ pyasn1 ];

  preConfigure = stdenv.lib.optionalString (isPy3k && pythonOlder "3.7") ''
    substituteInPlace setup.py --replace "open('README.md')" "open('README.md',encoding='utf-8')"
  '';

  meta = with stdenv.lib; {
    homepage = https://stuvel.eu/rsa;
    license = licenses.asl20;
    description = "A pure-Python RSA implementation";
  };
}
