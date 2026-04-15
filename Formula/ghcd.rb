class Ghcd < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghcd"
  version "1.0.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghcd/releases/download/v1.0.1/ghcd-darwin-arm64.tar.gz"
      sha256 "ae4020da3adbd49789371f8fd1271c0b08b81c2169d519a74f0719a14de7d047"
    else
      url "https://github.com/brunoborges/ghcd/releases/download/v1.0.1/ghcd-darwin-amd64.tar.gz"
      sha256 "5f513937e36b0455c0b8b09a53b59aa213a4cb6ba4d2513524b5c6c51cf2835a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghcd/releases/download/v1.0.1/ghcd-linux-arm64.tar.gz"
      sha256 "88242bbeed03a5a67a9bfb6ce27115404fc91122d28ecc9c67a842c6e074d248"
    else
      url "https://github.com/brunoborges/ghcd/releases/download/v1.0.1/ghcd-linux-amd64.tar.gz"
      sha256 "5635542a0af140d6b2f39fd879a95802ef3466d9c8da2fa3317221bc0647086b"
    end
  end

  def install
    bin.install "ghc"
    bin.install "ghcd"
  end

  test do
    assert_match "ghcd", shell_output("#{bin}/ghcd --help")
  end
end
