class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "1.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.6.0/ghx-darwin-arm64.tar.gz"
      sha256 "bc416f4a896dc180ff78113cc3de64c6c1dcf997c41bf2bcd359e9236ff0b3c5"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.6.0/ghx-darwin-amd64.tar.gz"
      sha256 "24dbc39fc415989eb06caf0bb7598c8f9248266179d02f731de42bb6d4298d9d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.6.0/ghx-linux-arm64.tar.gz"
      sha256 "628d40cbe99a369be5c27ace03fa59bd0ae20575a17314fa2eebc57cc4e5da62"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.6.0/ghx-linux-amd64.tar.gz"
      sha256 "f3af903ac6a4bb3d4f5066c070c0fb38edcdef15cdf23ba93b41b1bbeed381b5"
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
