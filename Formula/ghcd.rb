class Ghcd < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghcd"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghcd/releases/download/v1.0.0/ghcd-darwin-arm64.tar.gz"
      sha256 "af6e4ddcb8495c371e1f1572b098a2c674d73fcc4637de1fdc5d6a237959e836"
    else
      url "https://github.com/brunoborges/ghcd/releases/download/v1.0.0/ghcd-darwin-amd64.tar.gz"
      sha256 "255594cfd3a6a08dda5e552daf800dc4c0a2876d2b26347eea8a65867a235c8f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghcd/releases/download/v1.0.0/ghcd-linux-arm64.tar.gz"
      sha256 "b4d9e27b7cc39098ed9e9e38c0a0c84c9d92160a1f3bc3839cca23da61fc2827"
    else
      url "https://github.com/brunoborges/ghcd/releases/download/v1.0.0/ghcd-linux-amd64.tar.gz"
      sha256 "7d5a9326454567125a965253efe6e8c0f3430613b9af5fd1e55cdce1925ac74c"
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
