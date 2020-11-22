{ pkgs, stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "github-cli";
  version = "1.2.1";
  rev = "v${version}";

  src = fetchFromGitHub {
    inherit rev;
    owner = "cli";
    repo = "cli";
    sha256 = "1lk3lhw598v966c553a3j0bp6vhf03xg7ggv827vzs1s8gnhxshz";
  };

  doCheck = false;

  vendorSha256 = "0bkd2ndda6w8pdpvw8hhlb60g8r6gbyymgfb69dvanw5i5shsp5q";
  modSha256 = "1k0gvck9j7qkav8alf7iq5jfza2mhnwgfq11dv0chcafpxscpivq";

  meta = with stdenv.lib; {
    homepage = "https://github.com/cli/cli/";
    description = "GitHub’s official command line tool";
    platforms = platforms.linux ++ platforms.darwin;
    license = licenses.mit;
  };
}
