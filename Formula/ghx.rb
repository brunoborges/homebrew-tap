class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "0.0.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.2/ghx-darwin-arm64.tar.gz"
      sha256 "eaac2a8b486740ebdd22fb88bf0dbba5cb399993e2113b79e30b0e7f0b24cb91"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.2/ghx-darwin-amd64.tar.gz"
      sha256 "e6c45e1e5e09ae7e6b1e7fd814e40095c98cd548ada733a14e24d9b3ea68dfef"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.2/ghx-linux-arm64.tar.gz"
      sha256 "a9eddb87a004aac6afe16fb00826aaa7c69e9aa3d91676c0a7ab87446faebac8"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v0.0.2/ghx-linux-amd64.tar.gz"
      sha256 "163846c4bfd0e5efb6e0c8ef095e30ebb1f4ab2ad79997807ac2fe2fe491c28d"
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
