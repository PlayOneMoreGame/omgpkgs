{ stdenvNoCC,
  pkgs,
  fetchFromGitHub,
  # scss-lint-reporter-checkstyle,
}:
let
  omge = pkgs.emacs;
  emacsWithPackagesFn = (pkgs.emacsPackagesNgGen omge).emacsWithPackages;
  emacsWithPackages = emacsWithPackagesFn (epkgs: (with epkgs.melpaStablePackages; [
    evil-escape
  ]) ++ (with epkgs.melpaPackages; [
    a
    ac-ispell
    ace-jump-helm-line
    ace-link
    ace-window
    aggressive-indent
    all-the-icons
    anaconda-mode
    anzu
    async
    auto-compile
    auto-complete
    auto-highlight-symbol
    auto-yasnippet
    avy
    base16-theme
    bind-key
    bind-map
    blacken
    browse-at-remote
    bundler
    cargo
    centered-cursor-mode
    chruby
    cider
    cider-eval-sexp-fu
    clean-aindent-mode
    clj-refactor
    clojure-mode
    clojure-snippets
    column-enforce-mode
    company
    company-anaconda
    company-emacs-eclim
    company-nixos-options
    company-quickhelp
    company-shell
    company-statistics
    company-tern
    company-terraform
    company-web
    concurrent
    counsel
    counsel-projectile
    csharp-mode
    ctable
    cython-mode
    dactyl-mode
    dash
    dash-functional
    deferred
    define-word
    devdocs
    diff-hl
    diminish
    docker
    docker-tramp
    dockerfile-mode
    doom-modeline
    dotenv-mode
    dumb-jump
    eclim
    editorconfig
    edn
    elisp-slime-nav
    emmet-mode
    ensime
    epc
    epl
    esh-help
    eshell-prompt-extras
    eshell-z
    eval-sexp-fu
    evil
    evil-anzu
    evil-args
    evil-cleverparens
    evil-commentary
    evil-ediff
    evil-exchange
    evil-goggles
    evil-iedit-state
    evil-indent-plus
    evil-lion
    evil-lisp-state
    evil-magit
    evil-matchit
    evil-numbers
    evil-surround
    evil-textobj-line
    evil-tutor
    evil-visual-mark-mode
    evil-visualstar
    exec-path-from-shell
    expand-region
    eyebrowse
    f
    fancy-battery
    fill-column-indicator
    fish-mode
    flx
    flx-ido
    flycheck
    flycheck-bashate
    flycheck-package
    flycheck-pos-tip
    flycheck-rust
    fringe-helper
    fuzzy
    gh-md
    git-commit
    git-gutter
    git-gutter-fringe
    git-gutter-fringe-plus
    git-gutter-plus
    git-link
    git-messenger
    git-timemachine
    gitattributes-mode
    gitconfig-mode
    gitignore-mode
    gitignore-templates
    golden-ratio
    google-translate
    goto-chg
    gradle-mode
    groovy-imports
    groovy-mode
    haml-mode
    hcl-mode
    helm
    helm-ag
    helm-c-yasnippet
    helm-company
    helm-core
    helm-css-scss
    helm-descbinds
    helm-flx
    helm-git-grep
    helm-gitignore
    helm-make
    helm-mode-manager
    helm-nixos-options
    helm-projectile
    helm-purpose
    helm-pydoc
    helm-swoop
    helm-themes
    helm-xref
    hierarchy
    highlight-indentation
    highlight-numbers
    highlight-parentheses
    hl-todo
    ht
    htmlize
    hungry-delete
    hydra
    iedit
    imenu-list
    impatient-mode
    importmagic
    indent-guide
    inf-ruby
    inflections
    insert-shebang
    ivy
    js-doc
    js2-mode
    js2-refactor
    json-mode
    json-navigator
    json-reformat
    json-snatcher
    link-hint
    live-py-mode
    livid-mode
    lorem-ipsum
    lv
    macrostep
    magit
    magit-gitflow
    magit-popup
    magit-svn
    markdown-mode
    markdown-toc
    maven-test-mode
    meghanada
    memoize
    minitest
    move-text
    multiple-cursors
    mvn
    mwim
    nameless
    nginx-mode
    nix-mode
    nixos-options
    nodejs-repl
    omnisharp
    open-junk-file
    org-bullets
    overseer
    package-lint
    packed
    paradox
    paredit
    parent-mode
    parseclj
    parseedn
    password-generator
    pcache
    pcre2el
    peg
    persp-mode
    pfuture
    pip-requirements
    pipenv
    pippel
    pkg-info
    popup
    popwin
    pos-tip
    powerline
    powershell
    prettier-js
    projectile
    protobuf-mode
    pug-mode
    py-isort
    pyenv-mode
    pytest
    pythonic
    pyvenv
    racer
    rainbow-delimiters
    rake
    ranger
    rbenv
    request
    restart-emacs
    robe
    rspec-mode
    rubocop
    rubocopfmt
    ruby-hash-syntax
    ruby-refactor
    ruby-test-mode
    ruby-tools
    rust-mode
    rvm
    s
    sass-mode
    sbt-mode
    scala-mode
    scss-mode
    seeing-is-believing
    sesman
    shell-pop
    shrink-path
    simple-httpd
    skewer-mode
    slim-mode
    smartparens
    smeargle
    spaceline
    spaceline-all-the-icons
    sqlup-mode
    string-inflection
    swiper
    symbol-overlay
    symon
    systemd
    tablist
    tagedit
    tern
    terraform-mode
    tide
    toc-org
    toml-mode
    transient
    treemacs
    treemacs-evil
    treemacs-projectile
    typescript-mode
    unfill
    use-package
    uuidgen
    vi-tilde-fringe
    vimrc-mode
    visual-fill-column
    volatile-highlights
    web-beautify
    web-completion-data
    web-mode
    which-key
    window-purpose
    window-purpose
    winum
    with-editor
    writeroom-mode
    ws-butler
    xterm-color
    yaml-mode
    yapfify
    yasnippet
    yasnippet-snippets
  ]) ++ (with epkgs.elpaPackages; [
    mmm-mode
    queue
    spinner
    undo-tree
  ]) ++ [
    pkgs.emacsMelpa.font-lock-plus
    pkgs.emacsMelpa.org-plus-contrib
    pkgs.emacsMelpa.sql-indent

    pkgs.haskellPackages.ShellCheck
    pkgs.nodePackages.prettier
    pkgs.nodePackages.js-beautify
    pkgs.scss-lint
    # scss-lint-reporter-checkstyle
    pkgs.silver-searcher
    pkgs.python3Packages.epc
    pkgs.python3Packages.importmagic
    pkgs.python3Packages.yapf
  ]);
in
stdenvNoCC.mkDerivation {
  name = "omgmacs";
  snippets = ./src/snippets;
  banners = ./src/banners;
  config = ./src/spacemacs-cfg;
  scss_lint_cfg = ./src/scss-lint.yml;
  buildInputs = [ pkgs.makeWrapper ];
  propagatedBuildInputs = [
    emacsWithPackages
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

    makeWrapper ${emacsWithPackages}/bin/emacs $TEMPDIR/omge \
      --prefix PATH : ${with pkgs; lib.makeBinPath [
        nodePackages.prettier
        nodePackages.js-beautify
        git
        scss-lint
        python3Packages.importmagic
        python3Packages.yapf
      ]} \
      --set REAL_HOME "\$HOME" \
      --set-default SPACEMACS_CACHE "\$HOME/.cache/omgmacs/.cache/" \
      --set XDG_CONFIG_HOME "\$HOME/.config/omg" \
      --set XDG_CACHE_HOME "\$SPACEMACS_CACHE" \
      --set XDG_DATA_HOME "\$HOME/.cache/omgmacs/.local/share" \
      --set HOME "$out/lib" \
      --suffix EMACSLOADPATH ":" "$out/lib/.emacs.d/layers/+spacemacs/spacemacs-evil/local/evil-unimpaired:" \
      --add-flags --no-package-sync

    tr "'" \" < $TEMPDIR/omge > $out/bin/omge
    sed -i '$imkdir -p \$SPACEMACS_CACHE' $out/bin/omge
    chmod +x $out/bin/omge
  '';
}
