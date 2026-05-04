class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "1.5.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.2/ghx-darwin-arm64.tar.gz"
      sha256 "36f7a193f88bf370ae36aaccdaddb30a7facf4f29f11f04a017262d5d44f7a08"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.2/ghx-darwin-amd64.tar.gz"
      sha256 "afd94a9e2b0cc678cbcadcd299e169944cb945b9d38c2b5104c6ae7805f306c5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.2/ghx-linux-arm64.tar.gz"
      sha256 "6ad8300f47a0a18b2dfd66671394fd4565157cc556fad44d4e90ff3e447cfa99"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.2/ghx-linux-amd64.tar.gz"
      sha256 "9b3e5eb7b7358a3cf51170dd63dfeb154e916ea04114b21b7d685830071d6433"
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
