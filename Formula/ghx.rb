class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "1.5.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.4/ghx-darwin-arm64.tar.gz"
      sha256 "2085b2eba7dfe1a8cdb67c005313e5a0f6f8f78e6b6b5ba28c177ef9838c5c00"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.4/ghx-darwin-amd64.tar.gz"
      sha256 "909bf3f67c606cd160fcf394fa0e818bf3dcf1c87ef143db964199d451b4b677"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.4/ghx-linux-arm64.tar.gz"
      sha256 "de99d1aa5a28186565d9c10d8d1596f5ff296730d38e6919b4db8ad0ac0108b7"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.4/ghx-linux-amd64.tar.gz"
      sha256 "fccc5a77a40101b2c09a57f2e2662039cc80aabafa4f0a504332e93620152cf7"
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
