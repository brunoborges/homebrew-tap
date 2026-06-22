class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "1.5.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.3/ghx-darwin-arm64.tar.gz"
      sha256 "4bd0a90f3d549048a00947d9f30490ba207629e7491a793313487d4af25285c0"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.3/ghx-darwin-amd64.tar.gz"
      sha256 "e442a134ba69ccb133c6a64cc54171638dca39e47fe2fc999bd8b1c56bf1a1b6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.3/ghx-linux-arm64.tar.gz"
      sha256 "8a3c2f77ba2dc616103c898359cbfdcc4e5ee9273e9b1e287f39d136d81a0dd4"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.3/ghx-linux-amd64.tar.gz"
      sha256 "a76bb579542750aba3b2c3cc6770b4fffbcc52d4e43b80fa4b2476bc1346bedd"
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
