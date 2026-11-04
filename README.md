# homebrew-tlilli

Homebrew tap for [Tlilli](https://github.com/bioedca/Tlilli), a local desktop manuscript editor that turns any
MCP-capable coding agent into a disciplined scientific co-editor: strict turns, every change anchored to a
sentence, attributed to whoever wrote it, and reversible.

The tap holds one cask, `tlilli`, which installs the macOS app from the
[GitHub Releases of bioedca/Tlilli](https://github.com/bioedca/Tlilli/releases). GitHub Releases are the
canonical channel; this tap only points at them.

## Install

```sh
brew tap bioedca/tlilli
brew install --cask tlilli
```

Requires macOS 13 (Ventura) or newer, on Apple silicon or Intel.

## The app is unsigned

Tlilli is not signed with an Apple Developer ID and is not notarized: the project has no signing budget
(see the trust posture in the [documentation](https://bioedca.github.io/Tlilli/)). Gatekeeper therefore blocks
the first launch with "Tlilli is damaged and can't be opened". Either skip the quarantine flag at install time:

```sh
brew install --cask --no-quarantine tlilli
```

or clear it after installing:

```sh
xattr -dr com.apple.quarantine /Applications/Tlilli.app
```

Do not disable Gatekeeper globally. Verify what you downloaded instead: every release publishes a `SHA256SUMS`
file and a GitHub artifact attestation (Sigstore, SLSA provenance). From the first release on, the cask carries
the checksums and Homebrew verifies them on install; provenance is verified with the GitHub CLI:

```sh
brew fetch --cask tlilli
gh attestation verify "$(brew --cache --cask tlilli)" --repo bioedca/Tlilli
```

## How the cask is updated

Version bumps are not written by hand. When a release is published in `bioedca/Tlilli`, its `post-release.yml`
workflow opens a pull request in this repository that rewrites `version` and `sha256` in `Casks/tlilli.rb`.
CI runs `brew style --cask` and `brew audit --cask --strict` on every pull request and on `main`; the maintainer
merges. Until the first release the cask carries the placeholders `version "0.0.0"` and `sha256 :no_check`, and
the audit runs offline.

## Governance

This tap is maintained by the Tlilli project under the same governance, security policy and code of conduct as
the main repository, [bioedca/Tlilli](https://github.com/bioedca/Tlilli). Problems with the app belong in
[bioedca/Tlilli issues](https://github.com/bioedca/Tlilli/issues); problems with the cask itself belong here.

Documentation: <https://bioedca.github.io/Tlilli/>

## License

The files in this tap are released under the BSD-2-Clause license (Homebrew's convention for taps); see
[LICENSE](LICENSE). Tlilli itself is licensed in its own repository.
