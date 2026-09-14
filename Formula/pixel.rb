class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://github.com/LivioGama/pixel"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.6/pixel-v0.2.6-aarch64-apple-darwin.tar.gz"
      sha256 "5aa8c256ec53188a968e5775548b4829c3bdb479c3a6c50717b538de4f26786d"
    end
    # Intel Macs (pre-2020): no prebuilt binary. Build from source via:
    #   cargo build --release -p pixel-cli
  end

  on_linux do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.6/pixel-v0.2.6-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f1b797d7342f8477974ae4ae545e0c914899ddc35ac0d7bd091a851c1fda0aa2"
    end
    on_intel do
      url "https://github.com/LivioGama/pixel/releases/download/v0.2.6/pixel-v0.2.6-x86_64-unknown-linux-musl.tar.gz"
      sha256 "24510706f47864d1f6941029b2b4cade2b7452b0c59c1ed804333e66468a14c2"
    end
  end

  def install
    bin.install "bin/pixel"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pixel --version")
  end
end
