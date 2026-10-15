class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "1.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.6.0/ghx-darwin-arm64.tar.gz"
      sha256 "c47409d0ff0d764532bc4e23f30eb4b63a506e9c8cc6fa9aeb9b1f737062bfff"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.6.0/ghx-darwin-amd64.tar.gz"
      sha256 "5d687bca10a2be202d5920f0a4c314c69954ef453ce6319233b2517b55f5aea6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.6.0/ghx-linux-arm64.tar.gz"
      sha256 "a6ab16bc9ff28c0ff7f736b74932ac3948cf676c192031e6def985512dcd87f7"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.6.0/ghx-linux-amd64.tar.gz"
      sha256 "af3ce80ca4e51374040a8987d8eaa6d1784c397c2566c62980168c869f4149f3"
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
