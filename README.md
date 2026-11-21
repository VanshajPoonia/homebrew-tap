# blowhorn-ai/homebrew-tap

Homebrew formulae from [Blowhorn](https://blowhorn.ai).

```bash
brew tap blowhorn-ai/tap
```

## Tells

[Tells](https://tells.blowhorn.ai) runs the Blowhorn Tells bot-detection check from a terminal and prints the JSON report and a one-line verdict.

Install with npm:

```bash
npm i -g blowhorn-tells
tells --server-only
```

Or with Homebrew, which also installs Node:

```bash
brew install blowhorn-ai/tap/tells
tells --server-only
```

The npm package is [`blowhorn-tells`](https://www.npmjs.com/package/blowhorn-tells); the command it puts on PATH is `tells`. `tells --help` lists the flags and exit codes; the [Tells README](https://github.com/blowhorn-ai/tells#cli) documents the output.

`--server-only` needs nothing else. The default browser run loads Playwright, which a Homebrew install cannot find. For browser runs, use the npm install: `npm i -g blowhorn-tells playwright && npx playwright install chromium`.

The formula currently installs from the `v0.3.12` Git tag of [blowhorn-ai/tells](https://github.com/blowhorn-ai/tells). When npm latest is at least that version, `.github/workflows/update-formula.yml` rewrites `Formula/tells.rb` from the npm tarball. A lower npm version, or the staged-publishing placeholder, leaves the formula in place.

## Blowhorn CLI

The `blowhorn` formula installs the Blowhorn CLI only (not the desktop app). The desktop app still ships as the DMG on [blowhorn-ai/blowhorn](https://github.com/blowhorn-ai/blowhorn) releases.

```bash
brew install blowhorn-ai/tap/blowhorn
blowhorn setup
```

`Formula/blowhorn.rb` is stamped by `make release` in blowhorn-ai/blowhorn: that run attaches `blowhorn-cli-X.Y.Z.tar.gz` to the `desktop-vX.Y.Z` GitHub release and writes this formula to match. The formula is absent until the first desktop release that includes that step. `brew upgrade blowhorn` picks up later stamps.

## How the Tells formula stays current

`.github/workflows/update-formula.yml` runs every six hours and on demand (Actions > Update formula > Run workflow). It:

1. reads the latest `blowhorn-tells` version and its tarball from the public npm registry, and checks the tarball against the registry's sha512 integrity,
2. leaves the formula unchanged when that version is npm's staged-publishing placeholder, or is older than the version already in `Formula/tells.rb`,
3. otherwise clones [blowhorn-ai/tells](https://github.com/blowhorn-ai/tells) at the `v<version>` tag that matches that npm release (or a `tells_ref` you pass when running the workflow by hand) and renders `Formula/tells.rb` with `scripts/render-homebrew-formula.mjs`, which reads the package, tap and formula names from `schemas/cli-release.json`,
4. if the formula changed, runs `brew install`, `brew test` and `brew audit` on it, then commits `tells <version>` and pushes.

It uses only this repo's `GITHUB_TOKEN` (`contents: write`). There is no npm token and no cross-repo secret. GitHub turns off scheduled workflows in a public repo after 60 days without activity; if that happens, re-enable the workflow under Actions or run it by hand after a release.

The workflow file itself is sourced from [`packaging/homebrew-tap/`](https://github.com/blowhorn-ai/tells/tree/master/packaging/homebrew-tap) in blowhorn-ai/tells.
