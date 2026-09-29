class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://pixel-cli.dev/"
  # Homebrew validates a URL for every simulated OS/arch at tap
  # time; the per-target URLs in the on_* blocks are the ones
  # actually used. This top-level URL satisfies the check.
  url "https://github.com/LivioGama/pixel/releases/download/v0.6.1/pixel-v0.6.1-aarch64-apple-darwin.tar.gz"
  sha256 "9fd791a8e529be35cec0fd2c1bf88744e4bb5fb997984e66747d9d8e54307374"
  license "MIT"

  on_macos do
    on_intel do
      # No prebuilt Intel binary; refuse rather than install the
      # arm64 tarball. Build from source: cargo build --release -p pixel-cli
      depends_on arch: :arm64
    end

    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.6.1/pixel-v0.6.1-aarch64-apple-darwin.tar.gz"
      sha256 "9fd791a8e529be35cec0fd2c1bf88744e4bb5fb997984e66747d9d8e54307374"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.6.1/pixel-v0.6.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d6243c5641a8e07183d2571ab0c3652f1f184324c7f999fc2ffef404d0d07d29"
    end
    on_intel do
      url "https://github.com/LivioGama/pixel/releases/download/v0.6.1/pixel-v0.6.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2d4031ae68d1dffaf91c8f88297b9753414eaf9dfd9106367874da60564dbe22"
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
