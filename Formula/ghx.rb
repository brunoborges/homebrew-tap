class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "1.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.2.1/ghx-darwin-arm64.tar.gz"
      sha256 "86325f5022d6267d90b2db21a2d7524d5cd139c9bb6b50be85a9cf3a69b31164"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.2.1/ghx-darwin-amd64.tar.gz"
      sha256 "71e1eec2e6fbccd79b672665b5bfdbb07ceb15a110b1dc82d655cd504169b186"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.2.1/ghx-linux-arm64.tar.gz"
      sha256 "6737f4d9f3112591484ec532e21215c53c551ae46a722e408c87433c44c793a6"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.2.1/ghx-linux-amd64.tar.gz"
      sha256 "8ec2e0a484de14473c258293b8688c8b8e4946f883e579d50b43d09fef4a98be"
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
