{ stdenv, lib, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  pname = "nomad";
  version = "0.12.5";
  rev = "v${version}";

  goPackagePath = "github.com/hashicorp/nomad";
  subPackages = [ "." ];

  src = fetchFromGitHub {
    owner = "hashicorp";
    repo = pname;
    inherit rev;
    sha256 = "15cadw8rwdi7iphki8hg3jvxfh0cbxn4i0b1mds1j8z0s7j75mci";
  };

  # ui:
  #  Nomad release commits include the compiled version of the UI, but the file
  #  is only included if we build with the ui tag.
  # nonvidia:
  #  We disable Nvidia GPU scheduling on Linux, as it doesn't work there:
  #  Ref: https://github.com/hashicorp/nomad/issues/5535
  preBuild = let
    tags = [ "ui" ] ++ lib.optional stdenv.isLinux "nonvidia";
    tagsString = lib.concatStringsSep " " tags;
  in ''
    export buildFlagsArray=(
      -tags="${tagsString}"
    )
  '';

  meta = with lib; {
    homepage = "https://www.nomadproject.io/";
    description = "A Distributed, Highly Available, Datacenter-Aware Scheduler";
    platforms = platforms.unix;
    license = licenses.mpl20;
    maintainers = with maintainers; [ rushmorem pradeepchhetri endocrimes ];
  };
}
