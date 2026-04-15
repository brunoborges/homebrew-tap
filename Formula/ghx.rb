class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "0.0.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.2/ghx-darwin-arm64.tar.gz"
      sha256 "5a7fd05da23ee9c8b415c71ed0e5d1916ad31be2a5ee169ea470bd917c9340aa"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.2/ghx-darwin-amd64.tar.gz"
      sha256 "d9f1be5ce29902641ab0e247c7afa30b90b7ba60a1c79055946b7d323408d2e9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.2/ghx-linux-arm64.tar.gz"
      sha256 "689b6ee00d4b4062055a45d699676c85af8de7642402909690ee9385ccdbc689"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.2/ghx-linux-amd64.tar.gz"
      sha256 "4b97365b183d7b7d2a0ade61b351c48a7d03a8933057055b20bb05d28e199903"
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
