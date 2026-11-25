# Contributing to cypher-lite

Thank you for taking the time to help.

## Reporting a problem

Open an issue with the bug template. The most useful report has a short program that shows the
problem, what you expected, what happened, and your GHC and operating system versions.

## Proposing a change

1. For anything larger than a fix, open an issue first so the direction can be agreed before you
   write code.
2. Fork the repository and work on a branch.
3. Run the same checks as the CI before you push:

   ```bash
   devenv shell -- lib-ci
   ```

   Without devenv: `cabal build all --enable-tests --ghc-options=-Werror && cabal test all`.
4. Add a test for what you change, and a line under `## Unreleased` in `CHANGELOG.md`.
5. Open the pull request and fill in its template.

## What to expect

- A pull request is merged by a maintainer once the checks are green and the review is settled.
  Pull requests are squash-merged.
- A first review may be drafted with the help of an AI assistant. A maintainer reads every review
  before it is posted, and only a maintainer approves or merges.
- The public API follows the [Package Versioning Policy](https://pvp.haskell.org). Say in the pull
  request when a change breaks the API.

## Style

- Every exported name has a Haddock comment that says what it does.
- The code builds without warnings under `-Wall -Wcompat`.
- Dependencies have lower and upper bounds.

## Conduct

This project follows the [Code of Conduct](CODE_OF_CONDUCT.md).
