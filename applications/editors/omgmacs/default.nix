{ stdenvNoCC,
  pkgs,
  haskellPackages,
  nodePackages,
  python3Packages,
  fetchFromGitHub,
  # scss-lint-reporter-checkstyle,
}:
stdenvNoCC.mkDerivation {
  name = "omgmacs";
  # jw todo: Disable sandboxing to allow Linux machines to build the package.
  # This should be re-enabled once *all* emacs packages are managed
  # by Nix instead of relying on emacs to install them within the
  # postFixup stage of the package
  __noChroot = true;
  snippets = ./src/snippets;
  banners = ./src/banners;
  config = ./src/spacemacs-cfg;
  scss_lint_cfg = ./src/scss-lint.yml;
  buildInputs = [ pkgs.makeWrapper ];
  propagatedBuildInputs = [
    pkgs.cacert
    pkgs.emacs
    # Emacs package binary dependencies
    haskellPackages.ShellCheck
    nodePackages.prettier
    nodePackages.js-beautify
    pkgs.scss-lint
    pkgs.silver-searcher
    python3Packages.epc
    python3Packages.importmagic
    python3Packages.yapf
    # scss-lint-reporter-checkstyle
  ];
  src = fetchFromGitHub {
    owner = "syl20bnr";
    repo = "spacemacs";
    rev = "d4cca74854f0bde9d725146ae358fb101c604c2f";
    sha256 = "1ab8k9f6izxsjgs52bma935zkqrbf0s8vagf128wdym9wf79dh6n";
  };
  patches = [ ./001-spacemacs-cache.patch ];

  installPhase = ''
    mkdir -p $out/lib
    ln -s "$config" "$out/lib/.spacemacs"
    ln -s "$scss_lint_cfg" "$out/lib/.scss-lint.yml"
    cp -r $(pwd) "$out/lib/.emacs.d"
    chmod 755 -R "$out/lib/.emacs.d/private"

    rm -Rd "$out/lib/.emacs.d/private/snippets"

    ln -s "$banners" "$out/lib/.emacs.d/private/banners"
    ln -s "$snippets" "$out/lib/.emacs.d/private/snippets"

    chmod 555 -R "$out/lib/.emacs.d/private"

    mkdir -p $out/bin

    makeWrapper ${pkgs.emacs}/bin/emacs $TEMPDIR/omge \
      --prefix PATH : ${pkgs.lib.makeBinPath [
        nodePackages.prettier
        nodePackages.js-beautify
        pkgs.git
        pkgs.scss-lint
        python3Packages.importmagic
        python3Packages.yapf
      ]} \
      --set REAL_HOME "\$HOME" \
      --set-default SPACEMACS_CACHE "\$HOME/.omg.d/.cache/" \
      --set XDG_CONFIG_HOME "\$HOME/.omg.d/.config" \
      --set XDG_CACHE_HOME "\$SPACEMACS_CACHE" \
      --set XDG_DATA_HOME "\$HOME/.omg.d/.local/share" \
      --set HOME "$out/lib"

    tr "'" \" < $TEMPDIR/omge > $out/bin/omge
    sed -i '$imkdir -p \$SPACEMACS_CACHE' $out/bin/omge
    chmod +x $out/bin/omge
  '';

  # jw todo: Package all emacs packages with Nix instead of allowing a network
  # connection from the emacs binary. This package isn't "pure" because we don't
  # pass all dependencies into the closure.
  postFixup = ''
    export SPACEMACS_CACHE=/tmp/.cache
    $out/bin/omge -batch -kill --load "$out/lib/.emacs.d/init.el" --debug-init
  '';
}
