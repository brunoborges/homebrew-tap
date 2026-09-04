class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "1.5.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.5/ghx-darwin-arm64.tar.gz"
      sha256 "87297685ade97e884eda543dfc576b46fb93f7833318b474dcff826c7e24ed6e"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.5/ghx-darwin-amd64.tar.gz"
      sha256 "89d0c5366dad6d18979b3134b850f907e52b1e0048bc0fe215fbdaf1e147ced2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.5/ghx-linux-arm64.tar.gz"
      sha256 "312983ba19a6b323a42827e49f13d65dd34541d0e3257bbddaa3fd059108e0a1"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.5.5/ghx-linux-amd64.tar.gz"
      sha256 "304704de621781deb8ba6dfa5d2794aaa05c32afc0aafafa2b080183e1956253"
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
