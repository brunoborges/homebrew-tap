class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "1.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.4.0/ghx-darwin-arm64.tar.gz"
      sha256 "09b7399e0d0f27d0f8b6f614b47e7361ddcdcc3bdfd44f957f786abbcc88ecaa"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.4.0/ghx-darwin-amd64.tar.gz"
      sha256 "afe951293c1d10b1d99b148c692ad7585adfe2d7bbb6e9c9872904f95c15180b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.4.0/ghx-linux-arm64.tar.gz"
      sha256 "f082bc3f2db809f15f3cdda38b41b1bf4bd8219b2803c74027c315d0b00ac0c5"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.4.0/ghx-linux-amd64.tar.gz"
      sha256 "7ea76b1f2931a652d40216ac607c970826bf56821c9a2f19e5444ea3e3439f0a"
    end
  end

  def install
    bin.install "ghx"
    bin.install "ghxd"

    # Install the packaged gh shim unless a real (non-shim) gh CLI exists
    real_gh = ENV.fetch("PATH", "").split(File::PATH_SEPARATOR).any? do |dir|
      p = File.join(dir, "gh")
      next unless File.executable?(p)
      !(File.binread(p, 512).include?("ghx-shim") rescue false)
    end
    bin.install "gh" unless real_gh
  end

  def caveats
    <<~EOS
      ghx caches GitHub CLI calls to prevent API rate limiting.
      Use 'ghx' instead of 'gh' to benefit from caching.

      If no 'gh' binary was found during installation, a lightweight
      shim was installed that routes 'gh' calls through ghx.
    EOS
  end

  test do
    assert_match "ghxd", shell_output("#{bin}/ghxd --help")
  end
end
