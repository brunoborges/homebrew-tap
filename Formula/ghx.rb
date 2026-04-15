class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "0.0.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.1/ghx-darwin-arm64.tar.gz"
      sha256 "f2cd0254abb54a98bd7c7fc919e10800333b331af386426c4a580eb638624d78"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.1/ghx-darwin-amd64.tar.gz"
      sha256 "9c90429523e9594ecb991d9acfcb40f90b92166806f2b54fbb8e1e7a62f275f4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.1/ghx-linux-arm64.tar.gz"
      sha256 "17b8cc57c030b1ba5bed4d6549ad9ea5702e76e3fa3d15fd63ac57172c5f7e27"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.1/ghx-linux-amd64.tar.gz"
      sha256 "494bff3d100f5237a19283664778aed6e1e32e8bf878107d9bcb5cb0e36009b2"
    end
  end

  def install
    bin.install "ghx"
    bin.install "ghxd"
  end

  test do
    assert_match "ghxd", shell_output("#{bin}/ghxd --help")
  end
end
