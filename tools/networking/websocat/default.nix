{ stdenv, rustPlatform, fetchFromGitHub, darwin }:

rustPlatform.buildRustPackage rec {
  name = "websocat";
  version = "1.4.0";
  src = fetchFromGitHub {
    owner = "vi";
    repo = "websocat";
    rev = "v${version}";
    sha256 = "1qdpx21nqdi3krln0y49qv7gzbz68c5cyx27ps228bkbyjw0jrlc";
  };
  cargoSha256 = "02rh1gl2hm1xj69rdqm04xafzxxcn0mdr9qs61x6ydax3v6f1v03";
  doCheck = false;
  buildInputs = if !stdenv.isDarwin then
    [ ] # jw todo: what is this for linux?
  else
    [ darwin.Security ];
}
