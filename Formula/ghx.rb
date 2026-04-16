class Ghx < Formula
  desc "GitHub CLI Cache Proxy — caching daemon for gh to prevent API rate limiting"
  homepage "https://github.com/brunoborges/ghx"
  version "1.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.2.0/ghx-darwin-arm64.tar.gz"
      sha256 "de36d81ae412f020965cf538c230b3269e24632c4233665b0b1bad6b1606f992"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.2.0/ghx-darwin-amd64.tar.gz"
      sha256 "44fbb15f142c134a7dfc716990bb0b86590c1e59eebf74f3fe5eef89f1ad215b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/brunoborges/ghx/releases/download/v1.2.0/ghx-linux-arm64.tar.gz"
      sha256 "ada999e322fc8bd8b5cc2bd343f1d85b68fc3c6198bb5fcef3e50c80aba27e65"
    else
      url "https://github.com/brunoborges/ghx/releases/download/v1.2.0/ghx-linux-amd64.tar.gz"
      sha256 "28e4bf1c4031fbb8b966faa84669ca63dcaba7677e70bcceaf40426298088c7b"
    end
  end

  def install
    bin.install "ghx"
    bin.install "ghxd"
  end

  def post_install
    # Only install gh shim if no real gh binary is available on the system
    return if system("sh", "-c", "command -v gh >/dev/null 2>&1")

    (bin/"gh").write <<~SH
      #!/bin/sh
      # ghx-shim: this script redirects gh commands through ghx for caching
      exec ghx ""
    SH
    (bin/"gh").chmod 0755
  end

  def caveats
    <<~EOS
      ghx caches GitHub CLI calls to prevent API rate limiting.
      Use 'ghx' instead of 'gh' to benefit from caching.

      If no 'gh' binary was found during installation, a lightweight
      shim was installed that routes 'gh' calls through ghx.
      The real GitHub CLI will be auto-downloaded on first use.
    EOS
  end

  test do
    assert_match "ghxd", shell_output("#{bin}/ghxd --help")
  end
end
