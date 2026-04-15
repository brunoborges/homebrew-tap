class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "0.0.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.2/ghx-darwin-arm64.tar.gz"
      sha256 "aabc888ec2dbd632563a80b0b06457ae7d441228d33043ed2e8b924e109eb5a3"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.2/ghx-darwin-amd64.tar.gz"
      sha256 "edc876cad0f104ce697dc8dd9aaabef8a484eeda4101bb4ed8e5f6cd5f4780ef"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.2/ghx-linux-arm64.tar.gz"
      sha256 "a449bfe4e8786d2586181dadbe025f70d41994ee28919430625ae8b36791bd69"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.2/ghx-linux-amd64.tar.gz"
      sha256 "c587e7fe9f22747199b42b232fd07ad9303772a2ce791adaff218af7e912b171"
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
