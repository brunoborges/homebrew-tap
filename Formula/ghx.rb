class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "1.5.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.1/ghx-darwin-arm64.tar.gz"
      sha256 "7581749e3e7fa0f4ea52833ac683c37213dfbde4f4253b1826eb52674b193e40"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.1/ghx-darwin-amd64.tar.gz"
      sha256 "0ad7f8bb7d7c7af44a23b381ed39acb85c72d4749a184f5530359c5ae6917486"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.1/ghx-linux-arm64.tar.gz"
      sha256 "daf5b7dc68a2d94683b3ad6ceb2b0f5e9f4297f1bde92838f5998d601b0d047b"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.1/ghx-linux-amd64.tar.gz"
      sha256 "ba38e7ffb70f577bc2ebe580b3d3bdd6c82d25ddfa2519bf2c404b3105968815"
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
