{ pkgs ? import <nixpkgs> { } }:

with pkgs; rec {
  aws-amicleaner = with python3Packages;
    callPackage ./development/tools/aws-amicleaner { inherit argparse awscli; };

  dotnetCorePackages =
    recurseIntoAttrs (callPackage ./development/compilers/dotnet { });

  dotnet-sdk = dotnetCorePackages.sdk_2_1;

  dotnet-sdk_2 = dotnetCorePackages.sdk_2_1;

  dotnet-sdk_3 = dotnetCorePackages.sdk_3_1;

  dotnet-sdk_5 = dotnetCorePackages.sdk_5_0;

  dotnet-netcore = dotnetCorePackages.netcore_2_1;

  dotnet-aspnetcore = dotnetCorePackages.aspnetcore_2_1;

  github-cli = (callPackage ./development/tools/github-cli { });

  nodePackages_10_x = recurseIntoAttrs
    (callPackage ./development/node-packages/default-v10.nix {
      nodejs = pkgs.nodejs-10_x;
    });

  nodePackages = nodePackages_10_x;

  nomad = (callPackage ./applications/networking/cluster/nomad { });

  python3Packages =
    recurseIntoAttrs (callPackage ./development/python-packages { });

  scss-lint-reporter-checkstyle =
    callPackage ./development/tools/scss-lint-reporter-checkstyle { };

  vault-openvpn = callPackage ./tools/security/vault-openvpn { };

  unity-license-server = callPackage ./applications/networking/unity/license-server { };
}
