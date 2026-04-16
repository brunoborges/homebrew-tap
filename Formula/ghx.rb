class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "1.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.3.0/ghx-darwin-arm64.tar.gz"
      sha256 "74cfe984562dac92a3790873bdd91925d7cb4e8bcbe19acd5fc0c2ba05ecf42c"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.3.0/ghx-darwin-amd64.tar.gz"
      sha256 "c22af424b770f0e1629c7eebb310c884189d5af0c975fd144dcb8a8728deb9d1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.3.0/ghx-linux-arm64.tar.gz"
      sha256 "c75adc1914d554fb41f2689aceb0aab526a38835aa48225714b85b501fbaee2d"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.3.0/ghx-linux-amd64.tar.gz"
      sha256 "f49302828efbd2995e282951bbc529fa06ae0fa0bd0a7c0d3e03a7518694a18d"
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
