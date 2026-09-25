class Pixel < Formula
  desc "Local control layer for coding agents — deterministic retrieval + git engine"
  homepage "https://pixel-cli.dev/"
  # Homebrew validates a URL for every simulated OS/arch at tap
  # time; the per-target URLs in the on_* blocks are the ones
  # actually used. This top-level URL satisfies the check.
  url "https://github.com/LivioGama/pixel/releases/download/v0.5.1/pixel-v0.5.1-aarch64-apple-darwin.tar.gz"
  sha256 "8668796fc95a6fd8c1d5488666e482da404bac6d687a0761a4baba006d88f33e"
  license "MIT"

  on_macos do
    on_intel do
      # No prebuilt Intel binary; refuse rather than install the
      # arm64 tarball. Build from source: cargo build --release -p pixel-cli
      depends_on arch: :arm64
    end

    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.5.1/pixel-v0.5.1-aarch64-apple-darwin.tar.gz"
      sha256 "8668796fc95a6fd8c1d5488666e482da404bac6d687a0761a4baba006d88f33e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/LivioGama/pixel/releases/download/v0.5.1/pixel-v0.5.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e9a8dcf3906971ce14f8485932da73b78c4ae1716182dd43e41076148d88767d"
    end
    on_intel do
      url "https://github.com/LivioGama/pixel/releases/download/v0.5.1/pixel-v0.5.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "66ce10dca353037c843d69fd9e1e759de701dbb3263c207c5f7c8a460ac8755a"
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
