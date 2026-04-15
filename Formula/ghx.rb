class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "0.0.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.2/ghx-darwin-arm64.tar.gz"
      sha256 "ed1d90ed90bb2e057be6af6b146126cba138961add18ad7f4bd791796d0d66c2"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.2/ghx-darwin-amd64.tar.gz"
      sha256 "385175bbd1249824811561a3847dc68ad170e01416e0317b675d488154cad418"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.2/ghx-linux-arm64.tar.gz"
      sha256 "194103e0b06abe3859a3ec6cfad32ed913ea1ff06ebb165f5a9a4f7c0488a8de"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.2/ghx-linux-amd64.tar.gz"
      sha256 "c5f70528b28d035eda61bb00a3d1883f9aacdb9cd33c9bb45b63f7f852e9abd9"
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
