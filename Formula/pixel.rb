class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://github.com/LivioGama/pixel"
  # Homebrew validates a URL for every simulated OS/arch at tap
  # time; the per-target URLs in the on_* blocks are the ones
  # actually used. This top-level URL satisfies the check.
  url "https://github.com/LivioGama/pixel/releases/download/v0.3.1/pixel-v0.3.1-aarch64-apple-darwin.tar.gz"
  sha256 "d48f85031b891b6fd62f0f6f64d05a8201a5e7865c57d73d377bd970f8d1638d"
  license "MIT"

  on_macos do
    on_intel do
      # No prebuilt Intel binary; refuse rather than install the
      # arm64 tarball. Build from source: cargo build --release -p pixel-cli
      depends_on arch: :arm64
    end

    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.3.1/pixel-v0.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "d48f85031b891b6fd62f0f6f64d05a8201a5e7865c57d73d377bd970f8d1638d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.3.1/pixel-v0.3.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "18e94e66e7fa741b808e0ee302c56eef1bd34d0fd54b7300fbb9c81987be9a12"
    end
    on_intel do
      url "https://github.com/LivioGama/pixel/releases/download/v0.3.1/pixel-v0.3.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0e867e00f3a70716e9f84a39db0a5aabeb0f82db9c0fdd1fa0c72aae514f58a9"
    end
  end

  def install
    bin.install "bin/pixel"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pixel --version")
  end
end
