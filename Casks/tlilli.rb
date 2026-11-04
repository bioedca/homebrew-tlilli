cask "tlilli" do
  arch arm: "aarch64", intel: "x64"

  # Placeholders until the first release: `post-release.yml` in bioedca/Tlilli
  # rewrites `version` and `sha256` (one checksum per architecture) on every
  # published release, so these two lines are never edited by hand.
  version "0.0.0"
  sha256 :no_check

  url "https://github.com/bioedca/Tlilli/releases/download/v#{version}/Tlilli_#{version}_#{arch}.dmg"
  name "Tlilli"
  desc "Local desktop editor for scientific manuscripts with MCP agents as co-editors"
  homepage "https://bioedca.github.io/Tlilli/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "Tlilli.app"

  zap trash: [
    "~/Library/Application Support/io.github.bioedca.Tlilli",
    "~/Library/Caches/io.github.bioedca.Tlilli",
    "~/Library/HTTPStorages/io.github.bioedca.Tlilli",
    "~/Library/Logs/io.github.bioedca.Tlilli",
    "~/Library/Preferences/io.github.bioedca.Tlilli.plist",
    "~/Library/Saved Application State/io.github.bioedca.Tlilli.savedState",
    "~/Library/WebKit/io.github.bioedca.Tlilli",
  ]

  caveats <<~EOS
    Tlilli is not signed with an Apple Developer ID and is not notarized, so
    Gatekeeper blocks the first launch ("Tlilli is damaged and can't be opened").
    Either install without the quarantine flag:

      brew install --cask --no-quarantine tlilli

    or clear the flag after installing:

      xattr -dr com.apple.quarantine "#{appdir}/Tlilli.app"

    Do not disable Gatekeeper globally. Every release asset is listed in the
    release's SHA256SUMS file and carries a GitHub artifact attestation; verify
    the file Homebrew downloaded with:

      gh attestation verify "$(brew --cache --cask tlilli)" --repo bioedca/Tlilli
  EOS
end
