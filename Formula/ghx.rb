class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "1.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.0/ghx-darwin-arm64.tar.gz"
      sha256 "31d5c341d04fb88b6b2c864450137f5402f01bff04bb8177c48bc61c9724d8ce"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.0/ghx-darwin-amd64.tar.gz"
      sha256 "071e76311bce3bacd5496bbe2e87a4d05fa2f5904bcc7986865a2841f6541558"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.0/ghx-linux-arm64.tar.gz"
      sha256 "056e696163880b6f628745cdd9e56b24d3635366014b17b8ec5f28b4c4012ec3"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.0/ghx-linux-amd64.tar.gz"
      sha256 "e9e1faafdd36aea6fac851c90caaeda58d1fde5f14df0e6c92c2be17f0afc314"
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
