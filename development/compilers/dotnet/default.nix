# How to combine packages for use in development:
#
# latestCombined = combinePackages {
#   cli = sdk_3_1_preview;
#   withSdks = [ sdk_2_2 sdk_3_1 ];
#   withRuntimes = [ aspnetcore_2_1 sdk_2_2 sdk_3_1 ];
# };

{ callPackage
, stdenv
}:
let
  buildDotnet = attrs: callPackage (import ./buildDotnet.nix attrs) {};

  buildAspNetCore = attrs: buildDotnet (attrs // { type = "aspnetcore"; } );
  buildNetCore = attrs: buildDotnet (attrs // { type = "netcore"; } );
  buildNetCoreSdk = attrs: buildDotnet (attrs // { type = "sdk"; } );
in rec {
  combinePackages = attrs: callPackage (import ./combinePackages.nix attrs) {};

  sdk_2_2 = buildNetCoreSdk {
    version = "2.2.207";
    sha512 = if stdenv.isDarwin
               then "d60d683851ba08a8f30acac8c635219223a6f11e1efe5ec7e64c4b1dca44f7e3d6122ecc0a4e97b8b57c2035e22be5e09f5f1642db6227bb8898654da057a7ae"
               else "9d70b4a8a63b66da90544087199a0f681d135bf90d43ca53b12ea97cc600a768b0a3d2f824cfe27bd3228e058b060c63319cd86033be8b8d27925283f99de958";
  };
  sdk_3_1 = buildNetCoreSdk {
    version = "3.1.100";
    sha512 = if stdenv.isDarwin
               then "142922cfb98b0cae6b194c3da2478fdf70f2a67603d248bbf859938bd05c4a4a5facea05d49b0db8b382d8cf73f9a45246a2022c9cf0ccf1501b1138cd0b3e76"
               else "5217ae1441089a71103694be8dd5bb3437680f00e263ad28317665d819a92338a27466e7d7a2b1f6b74367dd314128db345fa8fff6e90d0c966dea7a9a43bd21";
  };
}
