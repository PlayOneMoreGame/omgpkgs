{ stdenv,
  buildGoPackage,
  fetchFromGitHub,
}:
buildGoPackage rec {
  name = "vault-openvpn";
  version = "1.9.1";
  rev = "v${version}";
  goPackagePath = "github.com/Luzifer/vault-openvpn";

  src = fetchFromGitHub {
    owner = "Luzifer";
    repo = "vault-openvpn";
    sha256 = "0cv4d42fkjdhgc370sisfgxy6z0d0w23k1ifq6z3cmylhxgbykbf";
    inherit rev;
  };
}
