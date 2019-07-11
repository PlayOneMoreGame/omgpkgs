{ lib,
  bundlerEnv,
  ruby
}:
bundlerEnv rec {
  name = "scss_lint_reporter_checkstyle";
  version = (import ./gemset.nix).scss_lint_reporter_checkstyle.version;
  gemdir = ./.;
  inherit ruby;

  meta = with lib; {
    description = "Extend the scss-lint with a Checkstyle formatter";
    homepage    = https://github.com/Sweetchuck/scss_lint_reporter_checkstyle;
  };
}
