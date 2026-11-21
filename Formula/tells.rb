# The v0.3.12 Git tag of https://github.com/blowhorn-ai/tells.
# blowhorn-tells is on the public npm registry. .github/workflows/update-formula.yml
# rewrites this file from the npm tarball when npm latest is newer than this
# formula's version, using scripts/render-homebrew-formula.mjs --from-npm in
# blowhorn-ai/tells. Do not delete this formula: a scheduled run that finds no
# newer npm release leaves this file in place.

class Tells < Formula
  desc "Bot-detection and browser fingerprint check that prints a JSON verdict"
  homepage "https://tells.blowhorn.ai"
  url "https://github.com/blowhorn-ai/tells.git",
      tag:      "v0.3.12",
      revision: "89cf459c5b8d9735f02db7215599ad8cde0dc764"
  license "Apache-2.0"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/tells --help")
  end
end
