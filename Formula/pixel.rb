class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://github.com/LivioGama/pixel"
  # Homebrew validates a URL for every simulated OS/arch at tap
  # time; the per-target URLs in the on_* blocks are the ones
  # actually used. This top-level URL satisfies the check.
  url "https://github.com/LivioGama/pixel/releases/download/v0.4.0/pixel-v0.4.0-aarch64-apple-darwin.tar.gz"
  sha256 "e66b309bd299465db2b6ce6187c734dbd338b5d347d5261bcd258170538e83fb"
  license "MIT"

  on_macos do
    on_intel do
      # No prebuilt Intel binary; refuse rather than install the
      # arm64 tarball. Build from source: cargo build --release -p pixel-cli
      depends_on arch: :arm64
    end

    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.4.0/pixel-v0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "e66b309bd299465db2b6ce6187c734dbd338b5d347d5261bcd258170538e83fb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.4.0/pixel-v0.4.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "16335b59f1d22e5ff2959707f4f5ed62dc8858fd733150c82f20f02fb04c4688"
    end
    on_intel do
      url "https://github.com/LivioGama/pixel/releases/download/v0.4.0/pixel-v0.4.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "846822a7cbc385abcb08b95675fb5d57aa655bea88a9b79dbcfa811940d3fcbe"
    end
  end

  def install
    bin.install "bin/pixel"
  end

  # An upgrade replaces the binary only; the agent wiring it
  # deployed lives in the user's home and is refreshed by
  # running pixel install.
  def caveats
    <<~EOS
      Homebrew upgrades replace the binary only. The agent prompt, shell
      wrapper and per-agent config keys are written by "pixel install"
      into your home, not by Homebrew, so they keep the old release's
      text until refreshed:

        pixel install
        pixel doctor .

      "pixel doctor" reports missing or stale wiring.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pixel --version")
  end
end
