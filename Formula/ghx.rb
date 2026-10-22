class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "1.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.7.0/ghx-darwin-arm64.tar.gz"
      sha256 "7680799727a516e40e395f1eb0f1637c4dead4a4bc9122b0493bbd5ed123ae98"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.7.0/ghx-darwin-amd64.tar.gz"
      sha256 "e3d6d9fd53ff4a594b14be08fa801b2a03478cf13a882da67e6bf772ba24d906"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.7.0/ghx-linux-arm64.tar.gz"
      sha256 "a04c8e476993fc0c0c4a0712648db482f77ecc56acba3594f95f1490b9f19882"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.7.0/ghx-linux-amd64.tar.gz"
      sha256 "70545347c6b42d010de5d640b091b87b507a57d8c53e5edc9780edfa8a7c91aa"
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
