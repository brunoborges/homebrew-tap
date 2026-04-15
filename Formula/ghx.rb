class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "1.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.1.1/ghx-darwin-arm64.tar.gz"
      sha256 "01ba2062051c5163bd3948a282f0f999be54e8aa21881712b35be7a82fa6bf0f"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.1.1/ghx-darwin-amd64.tar.gz"
      sha256 "8b204c019e8a51d2fa29780e61673c7c1665553ce9a0e920c22a82cd7864ddbf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.1.1/ghx-linux-arm64.tar.gz"
      sha256 "f540f81191ac5d2cbd85b641fead631a714786e0d41f446c977e24b7ee04cb8a"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.1.1/ghx-linux-amd64.tar.gz"
      sha256 "eb6ee78264e9f89973f5bbc1582f903b403080c58fbddf1d8680830c146d2eb0"
    end
  end

  conflicts_with "gh", because: "ghx includes a gh shim that routes all gh calls through the caching proxy"

  def install
    bin.install "ghx"
    bin.install "ghxd"
    bin.install "gh"
  end

  def caveats
    <<~EOS
      ghx includes a 'gh' shim that routes all GitHub CLI calls through
      the caching proxy. The real GitHub CLI will be auto-downloaded on
      first use if not already present.

      If you previously had 'gh' installed via Homebrew, ghx replaces it.
      To revert: brew uninstall ghx && brew install gh
    EOS
  end

  test do
    assert_match "ghxd", shell_output("#{bin}/ghxd --help")
  end
end
