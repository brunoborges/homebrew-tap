class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "1.7.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.7.1/ghx-darwin-arm64.tar.gz"
      sha256 "13fabdf7edc98fa96e273f02a1516387537e3d42895c0c8fec370f9d18a0f497"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.7.1/ghx-darwin-amd64.tar.gz"
      sha256 "d6178787d1f583cde2002ef9d388a905a2178506fe5f188420996a4af0b200d6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.7.1/ghx-linux-arm64.tar.gz"
      sha256 "31e29b65c627a13b35556384696678f6223b5ac8a0f59b2a453ecb75e93ce2c4"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.7.1/ghx-linux-amd64.tar.gz"
      sha256 "4c24f9bbee8672cde0639ddd5af77f29d348616aef88e53c711891e2a9c045f2"
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
