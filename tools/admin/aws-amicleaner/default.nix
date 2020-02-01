{ lib
, python3Packages
, argparse
, pkgs
}:

python3Packages.buildPythonApplication rec {
  pname = "aws-amicleaner";
  version = "0.2.2";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "1pwgrpiq3s23ghk09ha1acb5rbi82bzrc5yxaq7a4nay0lf75a68";
  };

  doCheck = false;

  propagatedBuildInputs = with pkgs; with python3Packages; [
    argparse
    awscli
    blessings
    boto
    boto3
    prettytable
  ];
}
