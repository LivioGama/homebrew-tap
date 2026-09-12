class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://github.com/LivioGama/pixel"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.1/pixel-v0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "b71cb244b831e4627095bc07a8a249acaaae00a2ceaa0701fe856c6f6a388931"
    end
    # Intel Macs (pre-2020): no prebuilt binary. Build from source via:
    #   cargo build --release -p pixel-cli
  end

  on_linux do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.1/pixel-v0.2.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d115735759f63a88eccda968789d31bef7f3dcb9aea2d9249a84ba8150d1dbea"
    end
    on_intel do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.1/pixel-v0.2.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0d9181cd9c86dbf806b60307dfa22b3c3a34a96e6c1e8eef916289e0203e1a1d"
    end
  end

  def install
    bin.install "bin/pixel"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pixel --version")
  end
end
