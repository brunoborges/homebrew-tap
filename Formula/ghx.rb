class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "1.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.1.0/ghx-darwin-arm64.tar.gz"
      sha256 "f7d04cf6e4b200196b52beae9813c43eeba9fe1b666bfc0b59d4aeb570ed1201"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.1.0/ghx-darwin-amd64.tar.gz"
      sha256 "1a16bed96501c7f17ff85dc5a7893823f52c4ea17f899eabd395beb17ea82fbb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.1.0/ghx-linux-arm64.tar.gz"
      sha256 "6c8ae42628718c37f8c2fda379ac8d8189ff9ca396fb2378cd4846dcc44d81b4"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.1.0/ghx-linux-amd64.tar.gz"
      sha256 "3398bcdca088251617e304f1673063606972656e69ebf092ee3061f86ff642de"
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
