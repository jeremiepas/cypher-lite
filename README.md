# cypher-lite

[![CI](https://github.com/jeremiepas/cypher-lite/actions/workflows/ci.yml/badge.svg)](https://github.com/jeremiepas/cypher-lite/actions/workflows/ci.yml)
[![Hackage](https://img.shields.io/hackage/v/cypher-lite.svg)](https://hackage.haskell.org/package/cypher-lite)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A parser for a subset of openCypher: MATCH, WHERE, RETURN and the write clauses.

## Use it

Add the package to the `build-depends` of your cabal file:

```cabal
build-depends: cypher-lite ^>=0.1
```

## Example

```haskell
{-# LANGUAGE OverloadedStrings #-}
import Cypher.Lite (parseStatement)
import Data.Text.IO qualified as T

main :: IO ()
main = case parseStatement "MATCH (a:Function) WHERE a.name STARTS WITH 'foo' RETURN a" of
  Left problem -> T.putStrLn problem
  Right statement -> print statement
```

## Build and test

The compiler and cabal are pinned with [devenv](https://devenv.sh):

```bash
devenv shell -- lib-ci      # build, tests, cabal check, docs, and a build from the source tarball
devenv shell -- lib-test    # the tests only
```

Without devenv, a GHC listed in `tested-with` and `cabal test` are enough.

## Versions and releases

Versions follow the [Package Versioning Policy](https://pvp.haskell.org). Each release is a tag
`v<version>`, a GitHub release with the source tarball, and the same tarball on
[Hackage](https://hackage.haskell.org/package/cypher-lite). See [CHANGELOG.md](CHANGELOG.md).

## Contributing

Issues and pull requests are welcome: see [CONTRIBUTING.md](CONTRIBUTING.md). To report a
vulnerability, see [SECURITY.md](SECURITY.md).

## License

[MIT](LICENSE)
