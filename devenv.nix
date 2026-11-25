# Toolchain of cypher-lite. Every build, test and release step runs through `devenv shell`, locally and
# in GitHub Actions, so the compiler and cabal are the same everywhere and nothing is installed by hand.
#
#   devenv shell -- lib-build     build the library and its tests, warnings are errors
#   devenv shell -- lib-test      run the test suite
#   devenv shell -- lib-docs      build the Haddock documentation the way Hackage wants it
#   devenv shell -- lib-check     `cabal check`: what Hackage would refuse or warn about
#   devenv shell -- lib-sdist     build the source tarball, then build and test from it alone
#   devenv shell -- lib-ci        all of the above, in that order (what the CI runs)
#   devenv shell -- lib-dist      the two files of a release: the source tarball and the docs tarball
{ pkgs, ... }:
let
  hp = pkgs.haskell.packages.ghc910;
in
{
  packages = [
    hp.ghc
    hp.cabal-install
    pkgs.zlib
    pkgs.pkg-config
    pkgs.git
    pkgs.gnutar
    pkgs.gzip
  ];

  scripts = {
    # -Werror is given here and not in the cabal file: a published library must still build when a
    # newer compiler adds a warning.
    lib-build.exec = ''cd "$DEVENV_ROOT" && cabal build all --enable-tests --ghc-options=-Werror "$@"'';
    lib-test.exec = ''cd "$DEVENV_ROOT" && cabal test all --enable-tests --ghc-options=-Werror --test-show-details=direct "$@"'';
    lib-docs.exec = ''cd "$DEVENV_ROOT" && cabal haddock --haddock-for-hackage --enable-documentation --builddir=dist-docs "$@"'';
    lib-check.exec = ''cd "$DEVENV_ROOT" && cabal check'';
    # The tarball is what Hackage receives: a file missing from it is found here, not by a user.
    lib-sdist.exec = ''
      set -eu
      cd "$DEVENV_ROOT"
      rm -rf dist-sdist
      cabal sdist --output-directory=dist-sdist
      mkdir dist-sdist/unpacked
      tar -xzf dist-sdist/*.tar.gz -C dist-sdist/unpacked --strip-components=1
      cd dist-sdist/unpacked
      printf 'packages: .\n' > cabal.project
      cabal build all --enable-tests
      cabal test all --enable-tests --test-show-details=direct
    '';
    lib-ci.exec = ''lib-build && lib-test && lib-check && lib-docs && lib-sdist'';
    lib-dist.exec = ''
      set -eu
      cd "$DEVENV_ROOT"
      rm -rf dist-release
      mkdir dist-release
      cabal sdist --output-directory=dist-release
      cabal haddock --haddock-for-hackage --enable-documentation --builddir=dist-docs
      cp dist-docs/*-docs.tar.gz dist-release/
      ls -l dist-release
    '';
  };

  enterShell = ''
    echo "cypher-lite: ghc $(ghc --numeric-version), cabal $(cabal --numeric-version)"
  '';
}
